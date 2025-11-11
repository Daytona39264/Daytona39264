#!/usr/bin/env python3
"""
Claude Tools Demo Script
Demonstrates Claude API with custom tools: get_weather and web_search
"""

import os
import json
import sys
from typing import Any, Dict, List
import requests
from anthropic import Anthropic


def get_weather(location: str, unit: str = "fahrenheit") -> Dict[str, Any]:
    """
    Get current weather for a location using OpenWeather API.

    Args:
        location: City name (e.g., "San Francisco, CA")
        unit: Temperature unit ("celsius" or "fahrenheit")

    Returns:
        Weather data including temperature, conditions, etc.
    """
    api_key = os.environ.get("OPENWEATHER_API_KEY")
    if not api_key:
        return {"error": "OPENWEATHER_API_KEY not set"}

    try:
        # OpenWeather API endpoint
        base_url = "http://api.openweathermap.org/data/2.5/weather"
        units = "metric" if unit == "celsius" else "imperial"

        params = {
            "q": location,
            "appid": api_key,
            "units": units
        }

        response = requests.get(base_url, params=params, timeout=10)
        response.raise_for_status()
        data = response.json()

        return {
            "location": data["name"],
            "temperature": data["main"]["temp"],
            "unit": unit,
            "conditions": data["weather"][0]["description"],
            "humidity": data["main"]["humidity"],
            "wind_speed": data["wind"]["speed"]
        }
    except Exception as e:
        return {"error": str(e)}


def web_search(query: str, num_results: int = 5) -> Dict[str, Any]:
    """
    Perform a web search using SerpAPI.

    Args:
        query: Search query string
        num_results: Number of results to return (default: 5)

    Returns:
        Search results with titles, links, and snippets
    """
    api_key = os.environ.get("SERPAPI_API_KEY")
    if not api_key:
        return {"error": "SERPAPI_API_KEY not set"}

    try:
        url = "https://serpapi.com/search"
        params = {
            "q": query,
            "api_key": api_key,
            "num": num_results,
            "engine": "google"
        }

        response = requests.get(url, params=params, timeout=10)
        response.raise_for_status()
        data = response.json()

        results = []
        for result in data.get("organic_results", [])[:num_results]:
            results.append({
                "title": result.get("title", ""),
                "link": result.get("link", ""),
                "snippet": result.get("snippet", "")
            })

        return {
            "query": query,
            "num_results": len(results),
            "results": results
        }
    except Exception as e:
        return {"error": str(e)}


# Define tool schemas for Claude
TOOLS = [
    {
        "name": "get_weather",
        "description": "Get the current weather for a specific location. Returns temperature, conditions, humidity, and wind speed.",
        "input_schema": {
            "type": "object",
            "properties": {
                "location": {
                    "type": "string",
                    "description": "The city and state/country, e.g., 'San Francisco, CA' or 'London, UK'"
                },
                "unit": {
                    "type": "string",
                    "enum": ["celsius", "fahrenheit"],
                    "description": "The temperature unit to use. Defaults to fahrenheit."
                }
            },
            "required": ["location"]
        }
    },
    {
        "name": "web_search",
        "description": "Search the web for information. Returns a list of search results with titles, links, and snippets.",
        "input_schema": {
            "type": "object",
            "properties": {
                "query": {
                    "type": "string",
                    "description": "The search query"
                },
                "num_results": {
                    "type": "integer",
                    "description": "Number of results to return (default: 5)",
                    "minimum": 1,
                    "maximum": 10
                }
            },
            "required": ["query"]
        }
    }
]


def process_tool_call(tool_name: str, tool_input: Dict[str, Any]) -> Any:
    """Execute the appropriate tool based on the tool name."""
    if tool_name == "get_weather":
        return get_weather(**tool_input)
    elif tool_name == "web_search":
        return web_search(**tool_input)
    else:
        return {"error": f"Unknown tool: {tool_name}"}


def run_claude_with_tools(prompt: str) -> Dict[str, Any]:
    """
    Run Claude with tools enabled.

    Args:
        prompt: The user's prompt/query

    Returns:
        Dictionary containing the conversation and results
    """
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        return {"error": "ANTHROPIC_API_KEY not set"}

    client = Anthropic(api_key=api_key)

    messages = [{"role": "user", "content": prompt}]
    conversation = []

    print(f"\n{'='*60}")
    print(f"User: {prompt}")
    print(f"{'='*60}\n")

    # Allow up to 5 turns of tool use
    for turn in range(5):
        response = client.messages.create(
            model="claude-3-5-sonnet-20241022",
            max_tokens=4096,
            tools=TOOLS,
            messages=messages
        )

        conversation.append({
            "role": "assistant",
            "content": response.content,
            "stop_reason": response.stop_reason
        })

        # Check if Claude wants to use tools
        if response.stop_reason == "tool_use":
            # Extract tool use blocks
            tool_uses = [block for block in response.content if block.type == "tool_use"]

            # Execute each tool
            tool_results = []
            for tool_use in tool_uses:
                tool_name = tool_use.name
                tool_input = tool_use.input

                print(f"🔧 Claude is using tool: {tool_name}")
                print(f"   Input: {json.dumps(tool_input, indent=2)}")

                # Execute the tool
                result = process_tool_call(tool_name, tool_input)

                print(f"   Result: {json.dumps(result, indent=2)}\n")

                tool_results.append({
                    "type": "tool_result",
                    "tool_use_id": tool_use.id,
                    "content": json.dumps(result)
                })

            # Add assistant message and tool results to conversation
            messages.append({"role": "assistant", "content": response.content})
            messages.append({"role": "user", "content": tool_results})

        elif response.stop_reason == "end_turn":
            # Claude is done, extract the final text response
            text_blocks = [block.text for block in response.content if hasattr(block, "text")]
            final_response = "\n".join(text_blocks)

            print(f"🤖 Claude: {final_response}\n")
            print(f"{'='*60}\n")

            return {
                "prompt": prompt,
                "response": final_response,
                "conversation": conversation,
                "turns": turn + 1
            }
        else:
            # Unexpected stop reason
            print(f"⚠️  Unexpected stop reason: {response.stop_reason}")
            break

    return {
        "prompt": prompt,
        "error": "Max turns reached without completion",
        "conversation": conversation
    }


def main():
    """Main execution function."""
    print("="*60)
    print("Claude Tools Demo - Weather & Web Search")
    print("="*60)

    # Example prompts that will trigger tool use
    prompts = [
        "What's the weather like in San Francisco and New York? Use celsius.",
        "Search the web for recent news about Anthropic AI and tell me what you find."
    ]

    all_results = []

    for prompt in prompts:
        result = run_claude_with_tools(prompt)
        all_results.append(result)

    # Save results to JSON file
    output_file = "results/output.json"
    os.makedirs("results", exist_ok=True)

    with open(output_file, "w") as f:
        json.dump({
            "results": all_results,
            "timestamp": str(__import__("datetime").datetime.now())
        }, f, indent=2)

    print(f"✅ Results saved to {output_file}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
