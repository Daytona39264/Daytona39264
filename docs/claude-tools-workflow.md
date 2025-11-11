# Claude Tools GitHub Actions Workflow

This workflow demonstrates how to use Claude AI with custom tools (weather and web search) in a GitHub Actions environment.

## Overview

The workflow runs Claude with two custom tools:
- **get_weather**: Fetches current weather data for a location using OpenWeather API
- **web_search**: Performs web searches using SerpAPI

## Setup Instructions

### 1. Required API Keys

You need to set up three secrets in your GitHub repository:

1. **ANTHROPIC_API_KEY** - Your Anthropic Claude API key
   - Get it from: https://console.anthropic.com/

2. **OPENWEATHER_API_KEY** - OpenWeather API key
   - Get it from: https://openweathermap.org/api

3. **SERPAPI_API_KEY** - SerpAPI key for web searches
   - Get it from: https://serpapi.com/

### 2. Adding Secrets to GitHub

1. Go to your repository on GitHub
2. Navigate to **Settings** > **Secrets and variables** > **Actions**
3. Click **New repository secret**
4. Add each of the three secrets listed above

### 3. Running the Workflow

The workflow can be triggered in two ways:

#### Manual Trigger
1. Go to **Actions** tab in your GitHub repository
2. Select **Run Claude tools (get_weather + web_search)** workflow
3. Click **Run workflow** button

#### Scheduled Run
The workflow is configured to run automatically daily at 12:00 UTC. You can modify the schedule in the workflow file:

```yaml
schedule:
  - cron: '0 12 * * *'  # Change time as needed
```

To disable automatic runs, remove or comment out the `schedule` section.

## Workflow Output

After the workflow completes:

1. Go to the **Actions** tab
2. Click on the completed workflow run
3. Download the **claude-tool-results** artifact
4. Extract the artifact to view:
   - `output.json` - Structured results from Claude
   - `console.log` - Full execution logs

## Customizing the Prompts

To change what questions Claude answers, edit `scripts/run_claude_tool.py`:

```python
# Find this section in the main() function:
prompts = [
    "What's the weather like in San Francisco and New York? Use celsius.",
    "Search the web for recent news about Anthropic AI and tell me what you find."
]
```

Add or modify prompts as needed.

## File Structure

```
.
├── .github/
│   └── workflows/
│       └── claude-tools.yml       # GitHub Actions workflow
├── scripts/
│   └── run_claude_tool.py         # Main Python script
├── requirements.txt               # Python dependencies
└── docs/
    └── claude-tools-workflow.md   # This file
```

## How It Works

1. **Workflow Trigger**: GitHub Actions starts the workflow (manual or scheduled)
2. **Setup**: Installs Python 3.11 and required dependencies
3. **Execution**: Runs the Python script with Claude API
4. **Tool Loop**:
   - Claude analyzes the prompt
   - Decides which tools to use
   - Executes weather/search tools
   - Synthesizes results into a response
5. **Results**: Saves output to JSON and uploads as artifact

## Example Output

```json
{
  "results": [
    {
      "prompt": "What's the weather like in San Francisco?",
      "response": "Based on the current weather data, San Francisco is experiencing partly cloudy conditions with a temperature of 18°C (64°F)...",
      "turns": 2
    }
  ],
  "timestamp": "2025-11-11 12:00:00"
}
```

## Troubleshooting

### Workflow Fails with "API key not set"
- Verify that all three secrets are properly configured in GitHub Settings
- Check that secret names match exactly (case-sensitive)

### Tool execution errors
- Check the `console.log` file in the artifacts
- Verify API keys are valid and have sufficient quota
- For OpenWeather: Free tier allows 1000 calls/day
- For SerpAPI: Free tier allows 100 searches/month

### Python dependency errors
- The workflow auto-installs dependencies from `requirements.txt`
- If custom packages are needed, add them to `requirements.txt`

## Cost Considerations

- **Anthropic API**: Charged per token (input + output)
- **OpenWeather API**: Free tier available (1000 calls/day)
- **SerpAPI**: Free tier available (100 searches/month)

Monitor your usage to avoid unexpected charges.

## Advanced Usage

### Adding More Tools

To add custom tools, edit `scripts/run_claude_tool.py`:

1. Define the tool function
2. Add the tool schema to the `TOOLS` list
3. Update `process_tool_call()` to handle the new tool

Example:
```python
def my_custom_tool(param: str) -> dict:
    # Your implementation
    return {"result": "data"}

# Add to TOOLS list
{
    "name": "my_custom_tool",
    "description": "Description of what it does",
    "input_schema": {
        "type": "object",
        "properties": {
            "param": {"type": "string", "description": "Parameter description"}
        },
        "required": ["param"]
    }
}
```

## Security Notes

- Never commit API keys to the repository
- Always use GitHub Secrets for sensitive data
- Review workflow logs before making them public
- Consider using environment-specific secrets for production

## License

This implementation is provided as-is for demonstration purposes.
