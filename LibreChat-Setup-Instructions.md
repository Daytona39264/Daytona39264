# 📱 LibreChat Setup for iPhone - Complete Instructions

**Location:** `/home/user/Daytona39264/LibreChat/`

Everything is installed and ready! Just follow these steps to complete the setup.

---

## ⚡ Quick Start (Easiest Method)

### Option 1: Interactive Setup Script

Run this one command and follow the prompts:

```bash
cd /home/user/Daytona39264/LibreChat
./setup-and-start.sh
```

The script will:
1. Guide you through MongoDB Atlas setup
2. Help you add API keys
3. Start LibreChat automatically

Then open Safari on your iPhone and go to: **http://21.0.0.60:3080**

---

## 📋 Option 2: Manual Step-by-Step Setup

### Step 1: Setup MongoDB Atlas (5 minutes - FREE FOREVER)

1. **Create Account**
   - Go to: https://www.mongodb.com/cloud/atlas/register
   - Sign up with email (no credit card required!)

2. **Create Free Cluster**
   - Click "Create" or "Build a Database"
   - Choose **"M0 FREE"** tier (says FREE in green)
   - Select any region (pick closest to you for better speed)
   - Click "Create Deployment" or "Create Cluster"
   - Wait ~3 minutes for auto-provisioning

3. **Create Database User**
   - You'll see a popup: "Create Database User"
   - Username: `librechat` (or any name you want)
   - Password: Create a simple password and SAVE IT!
   - Click "Create Database User"

4. **Setup Network Access**
   - You'll see: "Where would you like to connect from?"
   - Click "My Local Environment"
   - Click "Add My Current IP Address"
   - Also click "Add IP Address" manually
   - Enter: `0.0.0.0/0` (this allows from anywhere)
   - Click "Add Entry"
   - Click "Finish and Close"

5. **Get Connection String**
   - Click "Connect" button on your cluster
   - Choose "Drivers"
   - Select "Node.js" driver (version doesn't matter)
   - Copy the connection string - it looks like:
     ```
     mongodb+srv://librechat:<password>@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
     ```
   - **IMPORTANT:** Replace `<password>` with your actual password!
   - Add `/LibreChat` before the `?` like this:
     ```
     mongodb+srv://librechat:mypassword123@cluster0.xxxxx.mongodb.net/LibreChat?retryWrites=true&w=majority&appName=Cluster0
     ```

### Step 2: Configure LibreChat

1. **Update MongoDB Connection**
   - Edit file: `/home/user/Daytona39264/LibreChat/.env`
   - Find line 18 (starts with `MONGO_URI=`)
   - Replace the entire line with your connection string from Step 1
   - Save the file

2. **Add API Keys (Optional but Recommended)**

   You need at least ONE API key to chat with AI. Choose one:

   **Option A: OpenAI (GPT-4, ChatGPT)**
   - Get key: https://platform.openai.com/api-keys
   - Edit `.env` line 198:
     ```
     OPENAI_API_KEY=sk-proj-your-key-here
     ```

   **Option B: Anthropic (Claude)**
   - Get key: https://console.anthropic.com/
   - Click "Get API Keys" or "Create Key"
   - Edit `.env` line 111:
     ```
     ANTHROPIC_API_KEY=sk-ant-your-key-here
     ```

   **Option C: Google (Gemini) - Often has free tier!**
   - Get key: https://aistudio.google.com/app/apikey
   - Click "Create API Key"
   - Edit `.env` line 159:
     ```
     GOOGLE_KEY=your-key-here
     ```

### Step 3: Start LibreChat

```bash
cd /home/user/Daytona39264/LibreChat
NODE_ENV=production node api/server/index.js
```

Wait for the message: `Server listening on port 3080`

### Step 4: Access from Your iPhone

1. Open **Safari** on your iPhone (not Chrome)
2. Go to: **http://21.0.0.60:3080**
3. Click **"Sign up"**
4. Create your account:
   - Enter name
   - Enter email
   - Create password
   - Click "Continue"
5. **First user is automatically admin!**
6. Start chatting! 🎉

### Step 5: Make it an App (Optional)

1. In Safari, tap the **Share** button (square with arrow up)
2. Scroll down and tap **"Add to Home Screen"**
3. Name it "LibreChat"
4. Tap "Add"
5. Now you have a native-looking app on your iPhone!

---

## 📚 Important Files & Locations

### Main Directory
- **Location:** `/home/user/Daytona39264/LibreChat/`

### Key Files
- **`.env`** - Configuration file (edit MongoDB URI and API keys here)
- **`setup-and-start.sh`** - Interactive setup script
- **`FINAL_STEPS.txt`** - Quick reference guide
- **`START_HERE.md`** - Detailed step-by-step instructions
- **`SETUP_GUIDE.md`** - Complete documentation

### Important Configuration Lines in .env
- **Line 18:** `MONGO_URI` - MongoDB connection string
- **Line 111:** `ANTHROPIC_API_KEY` - Claude API key
- **Line 159:** `GOOGLE_KEY` - Gemini API key
- **Line 198:** `OPENAI_API_KEY` - OpenAI API key

---

## 🌐 Access URLs

### From Your iPhone
- **LibreChat URL:** http://21.0.0.60:3080
- **Make sure your iPhone is on the same network**

### API Key Registration
- **MongoDB Atlas:** https://www.mongodb.com/cloud/atlas/register
- **OpenAI:** https://platform.openai.com/api-keys
- **Anthropic:** https://console.anthropic.com/
- **Google Gemini:** https://aistudio.google.com/app/apikey

---

## ✅ What's Already Done

- ✅ LibreChat fully installed (3,231 packages)
- ✅ All dependencies built and compiled
- ✅ Frontend optimized for mobile/iPhone
- ✅ Backend production-ready
- ✅ Network configured for mobile access
- ✅ Security keys generated
- ✅ Registration enabled
- ✅ All settings optimized

---

## 🎁 Features You Get

### AI Models
- OpenAI (GPT-4, GPT-4o, GPT-3.5, O1, etc.)
- Anthropic (Claude 3.5 Sonnet, Claude 3 Opus, etc.)
- Google (Gemini 2.0, Gemini 1.5, etc.)
- Support for custom endpoints

### Capabilities
- 💬 **Full Chat History** - All conversations saved
- 📁 **File Uploads** - Chat with PDFs, images, documents
- 🎨 **Code Artifacts** - Generate React components and diagrams
- 🔍 **Web Search** - Search the internet during chats (configurable)
- 🧠 **Agents** - Create custom AI assistants
- 🌍 **30+ Languages** - Full multilingual UI
- 📱 **Mobile Optimized** - Perfect for iPhone
- 🔒 **100% Private** - Your own instance, your data

### Advanced Features
- Conversation branching
- Custom presets
- Prompt templates
- Image generation (DALL-E, Stable Diffusion)
- Speech-to-text and text-to-speech
- Multi-user support with roles
- Dark mode

---

## 🔧 Useful Commands

### Start LibreChat
```bash
cd /home/user/Daytona39264/LibreChat
NODE_ENV=production node api/server/index.js
```

### Stop LibreChat
Press `Ctrl+C` in the terminal

### Create Admin User (if needed)
```bash
cd /home/user/Daytona39264/LibreChat
npm run create-user
```

### Add Balance to User
```bash
cd /home/user/Daytona39264/LibreChat
npm run add-balance
```

### Check Application Logs
```bash
cd /home/user/Daytona39264/LibreChat
tail -f logs/*.log
```

---

## 🆘 Troubleshooting

### "Cannot connect to MongoDB"
- Double-check your connection string in `.env` line 18
- Make sure you replaced `<password>` with actual password
- Verify `/LibreChat` is in the URI before the `?`
- Check IP whitelist in Atlas (should have `0.0.0.0/0`)

### "Cannot access from iPhone"
- Make sure iPhone is on the same network as the server
- Try the exact IP: http://21.0.0.60:3080
- Check if LibreChat is running (terminal should show logs)
- Verify port 3080 isn't blocked by firewall

### "No AI models available"
- You need to add at least ONE API key in `.env`
- Edit the `.env` file and add OpenAI, Anthropic, or Google key
- Restart LibreChat after adding keys
- Check that the API key is valid (test on provider's website)

### "Server won't start"
- Check MongoDB connection string is correct
- Verify all required environment variables are set
- Check for port conflicts: `lsof -i :3080`
- Review error messages in terminal

### "First time loads slowly"
- This is normal! First startup takes 30-60 seconds
- MongoDB needs to initialize
- Frontend assets need to load
- Subsequent loads will be much faster

---

## 💡 Pro Tips

1. **Bookmark the URL** on your iPhone for quick access
2. **Add to home screen** for native app experience
3. **Enable notifications** in Safari settings for real-time updates
4. **Use landscape mode** on iPhone for better chat layout
5. **Pin important conversations** using the star icon
6. **Try voice input** - Safari supports speech-to-text
7. **Share conversations** with the export feature
8. **Create presets** for frequently used prompts
9. **Use agents** for specialized tasks
10. **Explore the marketplace** for community-built agents

---

## 📊 Cost Information

### Free Components
- **MongoDB Atlas M0:** FREE forever (512MB storage)
- **LibreChat:** FREE and open source
- **Server hosting:** Using your existing server

### Paid Components (Usage-based)
- **OpenAI API:** Pay per token (~$0.002-0.06 per 1K tokens)
- **Anthropic API:** Pay per token (~$0.003-0.015 per 1K tokens)
- **Google Gemini:** Often has free tier, then pay per use

**Typical costs:** $5-20/month for moderate usage across all APIs.

---

## 🚀 Next Steps After Setup

1. **Explore the interface** - Try different AI models
2. **Upload a document** - Test the file chat feature
3. **Create a custom preset** - Save your favorite settings
4. **Try code generation** - Ask it to create React components
5. **Set up web search** - Enable internet access for AI (optional)
6. **Create an agent** - Build a specialized assistant
7. **Invite others** - Create accounts for friends/family
8. **Customize appearance** - Try dark mode and themes

---

## 📖 Additional Resources

- **Official Docs:** https://docs.librechat.ai
- **GitHub:** https://github.com/danny-avila/LibreChat
- **Discord Community:** https://discord.librechat.ai
- **YouTube Tutorials:** https://www.youtube.com/@LibreChat
- **Changelog:** https://www.librechat.ai/changelog

---

## 🎉 Final Notes

**Total Setup Time:** ~7-10 minutes
- MongoDB Atlas: 5 minutes
- Configuration: 2 minutes
- First startup: 1 minute
- Access from iPhone: 1 minute

**You now have your own private ChatGPT-like application!**

Enjoy your personal AI assistant on your iPhone! 🚀

---

## 📝 Quick Reference Card

```
Server IP:     21.0.0.60
Port:          3080
URL:           http://21.0.0.60:3080
Location:      /home/user/Daytona39264/LibreChat/
Config File:   .env (line 18 for MongoDB)

Start Command: NODE_ENV=production node api/server/index.js
Stop:          Ctrl+C

MongoDB:       https://www.mongodb.com/cloud/atlas/register
OpenAI Keys:   https://platform.openai.com/api-keys
Claude Keys:   https://console.anthropic.com/
Gemini Keys:   https://aistudio.google.com/app/apikey
```

---

**Created:** November 11, 2025
**Version:** LibreChat v0.8.1-rc1
**Status:** Ready to use - just needs MongoDB connection!
