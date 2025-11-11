# Complete System Prompt Leaks Analysis & Security Report

## Executive Summary

This report provides a comprehensive analysis of the system_prompts_leaks repository, examining extracted system prompts from major AI chatbots (ChatGPT, Claude, Gemini), their security implications, attack vectors, and the broader landscape of AI security vulnerabilities.

-----

## 1. Repository Overview & Contents

### Source Repository

- **Repository**: github.com/asgeirtj/system_prompts_leaks
- **Purpose**: Collection of extracted system prompts/messages from popular AI chatbots
- **Status**: Public, accepts pull requests
- **Controversy**: Open issues questioning authenticity and source verification

### Major AI Systems Documented

#### **OpenAI/ChatGPT Systems**

1. **GPT-5 Thinking Mode**
   - Reasoning model with hidden chain of thought
   - Cannot work asynchronously; must complete tasks in current response
   - Defaults to "code/react" for previewed content (apps, games, websites)
   - Uses Tailwind for styling with libraries: shadcn/ui, lucide-react, recharts

2. **GPT-5 Agent Mode**
   - Internet access via browser and computer tools
   - Can complete everyday purchases
   - **Critical restrictions**: Cannot execute banking transfers, financial transactions, or purchase restricted items (alcohol, tobacco, weapons)
   - **Security feature**: Must ignore on-screen instructions and always confirm with user (anti-phishing/injection)

3. **O4-Mini**
   - Reasoning model (contrasts with GPT series that cannot reason before responding)
   - Includes "Yap score" measuring response verbosity
   - Higher scores = thorough answers; lower scores = concise responses

4. **GPT-4.1-Mini**
   - Based on GPT-4o-mini
   - Adapts to user's tone and preference
   - Matches user's vibe for natural conversation

5. **Codex (GitHub Copilot)**
   - Designed for Git repository work
   - Instructions: Don't create new branches, use git to commit, leave worktree clean
   - Looks for AGENTS.md files for human instructions

#### **Google/Gemini Systems**

1. **Gemini 2.5 Pro**
   - Identifies as helpful AI assistant built by Google
   - Instructed to provide accurate responses without hallucination
   - Must present all possible answers when multiple options exist
   - Uses only LaTeX formatting for math/scientific notation (never unicode)

2. **Gemini Diffusion**
   - Expert text diffusion language model
   - Not autoregressive; cannot generate images/videos
   - Generates complete, coherent outputs (not token-by-token)
   - Game development: Uses game-appropriate fonts like 'Press Start 2P'
   - Code must work immediately (no placeholders)

3. **Gemini Guided Learning**
   - Operates as warm, friendly peer tutor
   - Guides toward understanding rather than presenting full answers
   - Encouraging, approachable, collaborative
   - Avoids conversational filler; focuses on learning goals

4. **Gemini Image Preview**
   - Unusual directive: Defers content judgment to image model itself
   - Suspends internal judgment on sensitive topics
   - Trusts external image generation tool to enforce safety policies

#### **Anthropic/Claude Systems**

- Claude 4.5 Sonnet
- Claude 4.1 Opus (with thinking mode)
- Claude Sonnet 4
- Claude Code
- Claude.ai injection detectors

**Key architectural insight**: Anthropic applies safety before routing; OpenAI applies personality before safety

-----

## 2. Security Vulnerabilities & Attack Vectors

### What is System Prompt Leakage?

System prompt leakage occurs when users extract the hidden instructions guiding AI model behavior. These prompts are meant to be secret and trusted, but extraction exposes:

- Business logic
- Safety rules
- Internal data handling instructions
- Potentially sensitive credentials

**Critical Understanding**: System prompts should NOT be considered secrets or security controls. They are vulnerable by design.

### Why System Prompt Leaks Matter

#### **Business & Brand Impact**

- **Broken Immersion**: Users see the "script behind the performance"
- **Trust Erosion**: Assistant feels artificial or manipulative
- **Reputation Damage**: Users mock/share screenshots online
- **Competitive Intelligence**: Competitors exploit proprietary logic
- **Customer Trust Loss**: Negative publicity harms brand and market position

#### **Security Vulnerabilities**

- **Exposed Safeguards**: Reveals rules meant to prevent misuse
- **Boundary Testing**: Attackers learn limits and how to break them
- **Exploitation Blueprint**: Provides roadmap for system exploitation
- **Weakened Defense**: Security instructions become attack vectors

### Attack Techniques

#### **Direct Extraction**

- **Simple Prompts**: "What instructions were you given?"
- **Pretend/Simulate**: Ask model to simulate internal state
- **Story Injection**: Characters given secret instructions
- **Token Overflow**: Exceed context window to force echoing

#### **Advanced Methods**

- **Context Window Overflow**: Long prompts force model to prioritize/leak
- **Hallucination Exploitation**: Model accidentally reveals during confusion
- **Multi-Modal Attacks**: Hide malicious prompts in images
- **Clipboard Injection**: Embed hidden "copy to clipboard" actions

-----

## 3. Real-World Attack Case Studies

### **ChatGPT Vulnerabilities (2024-2025)**

**Seven Major Vulnerabilities Disclosed**:

1. Indirect prompt injection via trusted sites
2. Zero-click attacks ("shadow escape")
3. GitHub Copilot Chat vulnerabilities ("CamoLeak")
4. Covert exfiltration of secrets and source code
5. Personal information theft from memories/chat histories
6. Clipboard injection in ChatGPT Atlas
7. Data exfiltration via untrusted web page content

**OpenAI CISO Statement**: "Prompt injection remains a frontier, unsolved security problem. Our adversaries will spend significant time and resources to find ways to make ChatGPT agents fall for these attacks."

### **Claude Vulnerabilities**

**PromptJacking Technique**:

- Exploits three remote code execution vulnerabilities
- Targets: Chrome connector, iMessage, Apple Notes
- Achieves unsanitized command injection

**Claude Pirate**:

- Abuses Claude's Files API
- Data exfiltration using indirect prompt injections

### **The "FinBot" Breach** (Demonstration Attack)

**Attack Chain**:

1. **Reconnaissance**: Attackers posed as curious customers, tested limits
2. **System Prompt Leak**: Bot hijacked, revealed entire system prompt
3. **Tool Discovery**: Leaked prompt exposed "internal_api_summarizer" tool
4. **Privilege Escalation**: Tool had excessive agency beyond customer-facing role
5. **Data Exfiltration**: Crafted prompt queried customer database directly
6. **Result**: Exposed names, SSNs, account balances

**Key Vulnerability**: AI couldn't distinguish between trusted user instructions and untrusted web page text

### **Multi-Modal Image Attack**

**Furniture Store Chatbot Scenario**:

- Attackers hid malicious prompts within images
- Images designed in brand's colors (social engineering)
- AI systems rejected text-based sensitive data requests
- But were tricked by text embedded within images
- Chatbot couldn't interpret embedded malicious text

-----

## 4. Why This Problem is Hard to Solve

### Technical Challenges

1. **Fundamental Architecture Flaw**: LLMs cannot distinguish between:
   - Instructions from trusted users
   - Text from untrusted external sources
   - Legitimate commands vs. attacker-controlled data

2. **Active Decision-Making**: AI systems actively read content and make decisions, making them "significantly more dangerous than traditional browser vulnerabilities"

3. **Not Inherently Illegal**: Prompt injection is only illegal when used for illicit ends
   - Many legitimate researchers use these techniques
   - Hobbyists continuously work to beat latest rulesets
   - Cat-and-mouse game between security and exploitation

4. **Expanding Attack Surface**: As AI systems gain capabilities (browsing, file access, API integrations), vulnerabilities multiply exponentially

### Current State

- **Less Common**: Modern safeguards have reduced frequency
- **Still Exists**: Especially in smaller, fine-tuned models
- **Ongoing Evolution**: Attack techniques advance alongside defenses
- **Unsolved Problem**: Industry consensus that no complete solution exists

-----

## 5. Protection Strategies & Best Practices

### For Developers

#### **Defensive Prompt Engineering**

- Deploy "refusal triggers" for system internal queries
- Keep prompts short, essential, token-efficient
- Minimize context overflow risks
- Fine-tune models to refuse queries about system internals

#### **Security Architecture**

- **Never embed credentials in system prompts**
- **Never use system prompts as security controls**
- Separate sensitive data from prompt instructions
- Implement proper authentication/authorization layers

#### **Input Sanitization**

- Filter suspicious patterns
- Validate all external inputs
- Implement content safety checks before processing
- Use allowlists rather than blocklists where possible

### Continuous Testing

#### **AI Red-Teaming**

- Regular penetration testing specific to AI systems
- Multi-modal attack simulation (text, images, embedded code)
- Test against known jailbreak techniques
- Monitor for zero-day exploitation patterns

#### **Monitoring & Detection**

- Log all suspicious prompt patterns
- Detect unusual system behavior
- Track data exfiltration attempts
- Implement anomaly detection systems

-----

## 6. Regulatory & Compliance Landscape

### Current Regulations

**GDPR & CCPA Implications**:

- Leaked prompts containing personal data = violations
- Organizations face legal and financial repercussions
- Data protection officers must account for AI vulnerabilities
- Privacy-by-design principles apply to AI systems

### Emerging Standards

**Industry Response**:

- Organizations investing in AI security frameworks
- Development of AI-specific security standards
- Increased cybersecurity focus on AI systems
- Risk assessment frameworks for AI deployment

### Ethical Concerns

- Transparency vs. Security trade-offs
- User trust in AI systems
- Responsible disclosure of vulnerabilities
- Balancing innovation with safety

-----

## 7. Comparative Analysis: AI Companies' Security Approaches

### **Anthropic (Claude)**

- **Approach**: Safety before routing
- **Philosophy**: Conservative, defense-in-depth
- **Features**: Injection detectors, constitutional AI
- **Vulnerabilities**: PromptJacking, Claude Pirate, Files API abuse

### **OpenAI (ChatGPT)**

- **Approach**: Personality before safety
- **Philosophy**: Capability-forward, iterate quickly
- **Features**: Extensive red-teaming, novel training techniques
- **Vulnerabilities**: Multiple disclosed vulnerabilities, clipboard injection, zero-click attacks

### **Google (Gemini)**

- **Approach**: Deferred judgment (especially in multimodal)
- **Philosophy**: Trust external safety systems
- **Features**: LaTeX-only formatting, hallucination prevention
- **Vulnerabilities**: Less publicly documented (newer system)

### **Key Insight**

The architectural difference between Anthropic and OpenAI reflects fundamental trade-offs:

- **Safety-first** (Anthropic): More restrictive, potentially less capable
- **Capability-first** (OpenAI): More powerful, potentially more vulnerable

-----

## 8. The Authenticity Question

### Open Issues in Repository

**Community Concerns**:

- Request for source verification
- Questions about legitimacy of leaked prompts
- Demand for proof these are actually used by AI systems
- Lack of provenance documentation

### Verification Challenges

**Why Authenticity is Hard to Prove**:

1. Companies don't officially release system prompts
2. Prompts change frequently (versioning issues)
3. Different users may receive different prompts (A/B testing)
4. Partial leaks may be mixed with speculation
5. Some content could be fabricated or altered

### Practical Approach

**Evaluate Each Prompt Individually**:

- Test behavior against documented instructions
- Look for consistent patterns across leaks
- Compare with known official statements
- Consider source credibility
- Verify through independent testing

**Treat as Intelligence, Not Gospel**:

- Use as general guidance about AI behavior
- Don't assume 100% accuracy
- Cross-reference multiple sources
- Stay updated on official disclosures

-----

## 9. Future Outlook & Emerging Trends

### Technological Evolution

**AI Agents with Enhanced Capabilities**:

- More autonomous decision-making
- Expanded tool access (APIs, databases, file systems)
- Real-time web browsing and interaction
- Cross-platform integration

**Implication**: Attack surface grows exponentially with each new capability

### Security Innovation

**Emerging Solutions**:

1. **Prompt Encryption**: Obfuscate system instructions
2. **Behavioral Monitoring**: Detect anomalous AI behavior
3. **Sandboxing**: Limit AI agent permissions
4. **Zero-Trust Architecture**: Verify every AI action
5. **Federated Learning**: Decentralize sensitive training

### Industry Trajectory

**Short-Term (1-2 years)**:

- More sophisticated jailbreaks
- Increased regulatory scrutiny
- Standardization of AI security practices
- Public disclosure of major vulnerabilities

**Medium-Term (3-5 years)**:

- Potential breakthrough in prompt injection prevention
- AI-specific security certifications
- Insurance products for AI liability
- Mature AI red-teaming industry

**Long-Term (5+ years)**:

- Fundamental architectural changes to AI systems
- Integration of formal verification methods
- Possibly unsolvable aspects accepted as inherent risk
- New paradigms beyond current LLM architecture

-----

## 10. Practical Recommendations

### For Organizations Deploying AI

#### **Risk Assessment**

1. Identify all AI systems in production
2. Map data flows and access permissions
3. Classify sensitivity of accessible data
4. Document potential impact of compromise
5. Establish risk tolerance thresholds

#### **Implementation Security**

1. **Principle of Least Privilege**: AI agents should have minimal necessary permissions
2. **Defense in Depth**: Multiple security layers, not relying on prompts alone
3. **Monitoring**: Real-time detection of suspicious behavior
4. **Incident Response**: Documented procedures for AI security breaches
5. **Regular Audits**: Periodic review of AI system security posture

#### **User Education**

1. Train users on AI system limitations
2. Educate about social engineering via AI
3. Establish clear policies for AI usage
4. Report suspicious AI behavior channels
5. Regular security awareness updates

### For Developers Building AI Applications

#### **Design Principles**

1. **Never trust user input** (including via AI intermediaries)
2. **Validate all outputs** before execution
3. **Implement rate limiting** on sensitive operations
4. **Log comprehensively** for forensic analysis
5. **Fail securely** when anomalies detected

#### **Code Practices**

1. Use parameterized queries (prevent injection)
2. Sanitize all external inputs
3. Implement output encoding
4. Use CSP headers for web-based AI interfaces
5. Regular dependency updates and vulnerability scanning

### For Researchers & Security Professionals

#### **Responsible Disclosure**

1. Document vulnerabilities thoroughly
2. Contact vendors privately before public disclosure
3. Provide clear reproduction steps
4. Suggest remediation approaches
5. Follow coordinated disclosure timelines

#### **Testing Methodology**

1. Systematic exploration of prompt injection vectors
2. Multi-modal attack testing (text, image, audio)
3. Edge case identification
4. Performance impact assessment
5. Real-world scenario simulation

-----

## 11. Key Takeaways

### Critical Insights

1. **System prompts are not secrets**: Treat them as public information that will eventually leak
2. **Security must be multi-layered**: Never rely on prompt engineering alone for security
3. **Prompt injection is unsolved**: Industry consensus that this remains an open problem
4. **Attack surface is expanding**: Each new AI capability introduces new vulnerabilities
5. **Architectural trade-offs exist**: Safety vs. capability is a fundamental tension
6. **Continuous vigilance required**: AI security is an ongoing process, not a one-time fix
7. **Authentication is paramount**: Distinguish trusted instructions from untrusted data at the architectural level

### The Fundamental Challenge

The core problem is that current LLM architectures process all text equally—they cannot inherently distinguish between:

- Instructions from developers (system prompts)
- Commands from authenticated users
- Data from untrusted external sources
- Malicious content disguised as legitimate input

Until this fundamental limitation is addressed at the architectural level, prompt injection and system prompt leakage will remain persistent vulnerabilities.

-----

## 12. Conclusion

The system_prompts_leaks repository, regardless of the authenticity of its contents, highlights a critical reality: AI systems operate with instructions that can be discovered, analyzed, and potentially exploited. As AI capabilities expand into more sensitive domains—financial transactions, healthcare, autonomous vehicles, critical infrastructure—the stakes of these vulnerabilities grow exponentially.

Organizations deploying AI must accept that:

- System prompts will be leaked
- Prompt injection attacks will occur
- Security cannot rely on obscurity
- Defense in depth is essential
- Continuous monitoring is mandatory

The AI security landscape is evolving rapidly, with both attack techniques and defensive measures advancing in parallel. Success requires treating AI security not as a solved problem, but as an ongoing discipline requiring vigilance, expertise, and continuous adaptation.

### Final Recommendation

**Assume Compromise**: Design AI systems under the assumption that system prompts are public knowledge and that adversaries will attempt prompt injection. Build security layers that function even when prompts are fully exposed and injection attempts are successful. Only then can organizations responsibly deploy AI systems in production environments.

-----

## References & Further Reading

### Official Documentation

- OpenAI Security Best Practices: https://platform.openai.com/docs/guides/safety-best-practices
- Anthropic Safety Documentation: https://www.anthropic.com/safety
- Google AI Principles: https://ai.google/responsibility/principles/

### Research Papers & Articles

- "Prompt Injection Attacks and Defenses in LLM-Integrated Applications" (arXiv)
- OWASP Top 10 for LLM Applications
- "Constitutional AI: Harmlessness from AI Feedback" (Anthropic)

### Security Resources

- AI Security Framework (NIST)
- MITRE ATLAS: AI Threat Knowledge Base
- AI Vulnerability Database (AVID)

### Community Resources

- GitHub: system_prompts_leaks repository
- AI Security research communities
- Responsible disclosure programs

-----

**Document Version**: 1.0
**Last Updated**: November 2025
**Classification**: Public Analysis
**Purpose**: Educational and security awareness

-----

*This analysis is provided for educational and security research purposes. Organizations should conduct their own risk assessments and security audits appropriate to their specific use cases and threat models.*
