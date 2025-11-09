#!/usr/bin/env node

/**
 * Claude Code Handler
 *
 * This script handles Claude Code requests from GitHub PRs and Issues.
 * It integrates with the Anthropic API to provide AI-powered code assistance.
 */

const { Anthropic } = require('@anthropic-ai/sdk');
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// Environment variables
const ANTHROPIC_API_KEY = process.env.ANTHROPIC_API_KEY;
const GITHUB_TOKEN = process.env.GITHUB_TOKEN;
const PR_NUMBER = process.env.PR_NUMBER;
const INSTRUCTION = process.env.INSTRUCTION;
const TRIGGER_TYPE = process.env.TRIGGER_TYPE;
const REPO_OWNER = process.env.REPO_OWNER;
const REPO_NAME = process.env.REPO_NAME;

// Validate environment
if (!ANTHROPIC_API_KEY) {
  console.error('❌ ANTHROPIC_API_KEY is not set');
  process.exit(1);
}

// Initialize Anthropic client
const anthropic = new Anthropic({
  apiKey: ANTHROPIC_API_KEY,
});

/**
 * Execute shell command and return output
 */
function execCommand(command) {
  try {
    return execSync(command, { encoding: 'utf-8', stdio: 'pipe' });
  } catch (error) {
    console.error(`Command failed: ${command}`);
    console.error(error.message);
    return '';
  }
}

/**
 * Get PR information from GitHub
 */
function getPRInfo() {
  console.log(`📥 Fetching PR #${PR_NUMBER} information...`);

  const prInfo = execCommand(
    `gh pr view ${PR_NUMBER} --json title,body,files,reviews,comments,labels,headRefName`
  );

  if (!prInfo) {
    throw new Error('Failed to fetch PR information');
  }

  return JSON.parse(prInfo);
}

/**
 * Get PR diff
 */
function getPRDiff() {
  console.log('📄 Fetching PR diff...');
  return execCommand(`gh pr diff ${PR_NUMBER}`);
}

/**
 * Get CI status
 */
function getCIStatus() {
  console.log('🔍 Checking CI status...');
  return execCommand(`gh pr checks ${PR_NUMBER} 2>&1 || true`);
}

/**
 * Get changed files content
 */
function getChangedFiles(files) {
  console.log('📂 Reading changed files...');

  const fileContents = {};
  for (const file of files.slice(0, 10)) { // Limit to 10 files
    const filePath = file.path;
    if (fs.existsSync(filePath) && fs.statSync(filePath).size < 100000) {
      // Skip large files
      try {
        fileContents[filePath] = fs.readFileSync(filePath, 'utf-8');
      } catch (error) {
        console.warn(`⚠️ Could not read ${filePath}: ${error.message}`);
      }
    }
  }

  return fileContents;
}

/**
 * Determine the appropriate instruction based on trigger type
 */
function getEffectiveInstruction(triggerType, instruction, ciStatus) {
  if (triggerType === 'ci_failure') {
    return `The CI checks are failing. Here are the errors:\n\n${ciStatus}\n\nPlease analyze the errors and fix them.`;
  }

  if (triggerType === 'label') {
    return 'Please review this pull request and make any necessary improvements to the code quality, error handling, documentation, and tests.';
  }

  // Extract instruction from @claude-code mention
  if (instruction.includes('@claude-code')) {
    return instruction.replace('@claude-code', '').trim();
  }

  return instruction;
}

/**
 * Build context for Claude
 */
function buildContext(prInfo, diff, ciStatus, fileContents) {
  const effectiveInstruction = getEffectiveInstruction(TRIGGER_TYPE, INSTRUCTION, ciStatus);

  let context = `# Claude Code Request

You are Claude Code, an AI assistant integrated into a GitHub workflow. You have been asked to help with a pull request.

## Pull Request Information

**PR #${PR_NUMBER}**: ${prInfo.title}
**Branch**: ${prInfo.headRefName}

**Description**:
${prInfo.body || 'No description provided'}

**Labels**: ${prInfo.labels.map(l => l.name).join(', ') || 'None'}

## Request

${effectiveInstruction}

## CI Status

${ciStatus || 'No CI information available'}

## Code Changes

<diff>
${diff.slice(0, 20000) /* Limit diff size */}
</diff>

`;

  // Add file contents if available
  if (Object.keys(fileContents).length > 0) {
    context += '\n## Changed Files\n\n';
    for (const [filePath, content] of Object.entries(fileContents)) {
      context += `### ${filePath}\n\n\`\`\`\n${content.slice(0, 5000)}\n\`\`\`\n\n`;
    }
  }

  context += `
## Task

Based on the request and context above, please make the necessary code changes to address the request.

Important:
- Make focused, targeted changes
- Ensure code quality and best practices
- Add comments where helpful
- Preserve existing code style
- Test your changes mentally before applying

Please analyze the request and make appropriate changes to the codebase.
`;

  return context;
}

/**
 * Simple file operation tools
 */
const tools = [
  {
    name: 'read_file',
    description: 'Read the contents of a file from the repository',
    input_schema: {
      type: 'object',
      properties: {
        path: {
          type: 'string',
          description: 'The path to the file to read (relative to repository root)',
        },
      },
      required: ['path'],
    },
  },
  {
    name: 'write_file',
    description: 'Write content to a file in the repository',
    input_schema: {
      type: 'object',
      properties: {
        path: {
          type: 'string',
          description: 'The path to the file to write (relative to repository root)',
        },
        content: {
          type: 'string',
          description: 'The complete content to write to the file',
        },
      },
      required: ['path', 'content'],
    },
  },
  {
    name: 'list_files',
    description: 'List files in a directory',
    input_schema: {
      type: 'object',
      properties: {
        path: {
          type: 'string',
          description: 'The directory path to list (relative to repository root, default: ".")',
          default: '.',
        },
      },
    },
  },
];

/**
 * Execute tool calls
 */
function executeTool(toolName, toolInput) {
  console.log(`🔧 Executing tool: ${toolName}`);

  switch (toolName) {
    case 'read_file': {
      const filePath = toolInput.path;
      if (!fs.existsSync(filePath)) {
        return { error: `File not found: ${filePath}` };
      }
      try {
        const content = fs.readFileSync(filePath, 'utf-8');
        return { content };
      } catch (error) {
        return { error: error.message };
      }
    }

    case 'write_file': {
      const filePath = toolInput.path;
      const content = toolInput.content;

      try {
        // Ensure directory exists
        const dir = path.dirname(filePath);
        if (!fs.existsSync(dir)) {
          fs.mkdirSync(dir, { recursive: true });
        }

        fs.writeFileSync(filePath, content, 'utf-8');
        console.log(`  ✅ Wrote ${filePath}`);
        return { success: true, message: `Successfully wrote ${filePath}` };
      } catch (error) {
        return { error: error.message };
      }
    }

    case 'list_files': {
      const dirPath = toolInput.path || '.';
      try {
        const files = fs.readdirSync(dirPath);
        return { files };
      } catch (error) {
        return { error: error.message };
      }
    }

    default:
      return { error: `Unknown tool: ${toolName}` };
  }
}

/**
 * Main function
 */
async function main() {
  console.log('🤖 Claude Code Handler Starting...');
  console.log(`   PR: #${PR_NUMBER}`);
  console.log(`   Trigger: ${TRIGGER_TYPE}`);

  try {
    // Gather context
    const prInfo = getPRInfo();
    const diff = getPRDiff();
    const ciStatus = getCIStatus();
    const fileContents = getChangedFiles(prInfo.files || []);

    // Build context for Claude
    const context = buildContext(prInfo, diff, ciStatus, fileContents);

    console.log('\n🧠 Calling Claude API...\n');

    // Initial message to Claude
    let messages = [
      {
        role: 'user',
        content: context,
      },
    ];

    let continueLoop = true;
    let iterationCount = 0;
    const maxIterations = 10;

    while (continueLoop && iterationCount < maxIterations) {
      iterationCount++;

      const response = await anthropic.messages.create({
        model: 'claude-sonnet-4-5-20250929',
        max_tokens: 8096,
        tools: tools,
        messages: messages,
      });

      console.log(`\n📨 Response (iteration ${iterationCount}):`);
      console.log(`   Stop reason: ${response.stop_reason}`);

      // Process response content
      let toolResults = [];
      let hasToolUse = false;

      for (const content of response.content) {
        if (content.type === 'text') {
          console.log(`\n💬 Claude says:\n${content.text}\n`);
        } else if (content.type === 'tool_use') {
          hasToolUse = true;
          const toolResult = executeTool(content.name, content.input);
          toolResults.push({
            type: 'tool_result',
            tool_use_id: content.id,
            content: JSON.stringify(toolResult),
          });
        }
      }

      // Check if we should continue
      if (response.stop_reason === 'end_turn' || !hasToolUse) {
        continueLoop = false;
      } else {
        // Add assistant response and tool results to conversation
        messages.push({
          role: 'assistant',
          content: response.content,
        });

        messages.push({
          role: 'user',
          content: toolResults,
        });
      }
    }

    console.log('\n✅ Claude Code processing complete!');

  } catch (error) {
    console.error('\n❌ Error:', error.message);
    if (error.response) {
      console.error('API Response:', error.response.data);
    }
    process.exit(1);
  }
}

// Run main function
main().catch((error) => {
  console.error('Fatal error:', error);
  process.exit(1);
});
