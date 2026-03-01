# OpenClaw VPS Setup Guide

> No coding required. A complete guide to running a 24/7 AI agent on your own server.
>
> Thanks to [kokoju007](https://github.com/kokoju007), this repository is maintained and improved from their original project to help set up OpenClaw quickly and easily.  
>Original repository: https://github.com/kokoju007/openclaw-setup  
>X: https://x.com/supernovajunn  

From **Contabo VPS signup to Telegram connection** — every step covered, even for non-developers.  
This guide is specifically written for **Contabo VPS (Cloud VPS)**.

---

## ⚡ One-Line Install

SSH into your VPS and paste this single command:

```bash
curl -fsSL https://raw.githubusercontent.com/Daehan-Base/openclaw-setup/main/install_en.sh | bash
```

What it handles automatically:
- ✅ Node.js installation check
- ✅ OpenClaw installation
- ✅ Telegram bot connection
- ✅ Secure config file setup
- ✅ 24/7 auto-start service registration

---

## 📋 What You'll Need

| Item | Where to get it | Cost |
|------|----------------|------|
| VPS (Ubuntu 22.04) | [Contabo](https://contabo.com) | ~$6.99/mo |
| Claude API Key | [console.anthropic.com](https://console.anthropic.com) | Pay per use |
| Telegram Bot Token | Telegram @BotFather | Free |
| Telegram User ID | Telegram @userinfobot | Free |

---

## 📖 Full Guide

Download the PDF guide from the **Releases** tab.

Step-by-step instructions with screenshots:
Contabo signup → SSH access → Installation → Telegram connection → API key setup

### OpenClaw VPS setup guide

- Korean: [vps/README.md](./vps/README.md)
- English: [vps/README.en.md](./vps/README.en.md)

This guide includes Contabo signup, VPS creation, and SSH access steps with screenshots.

---

## 🔒 Security

This script guarantees:

- No automatic execution of external code (no eval/exec)
- Your credentials are never sent externally (tokens stay on your server)
- Only official packages used (npm + apt official repositories)
- Config file permissions locked automatically (chmod 600)
- No destructive commands (no rm -rf)

The full source code is public — inspect it yourself.

## ⚠️ Disclaimer

- This guide is provided for technical reference only. Final responsibility for account security, secret management, and server access control during install and operation remains with the user.
- Do not share secrets such as API keys, bot tokens, SSH keys, or passwords via chat. Store them locally using secure methods (environment variables, secret files, masked inputs, or equivalent safe mechanisms).
- Although this script is based on open-source code, review it against your environment and security policies before running it.

---

## 🛠 Useful Commands

```bash
# Check status
sudo systemctl status openclaw

# Restart
sudo systemctl restart openclaw

# Live logs
sudo journalctl -u openclaw -f

# Stop
sudo systemctl stop openclaw
```

---

## ❓ FAQ

**Q. The bot isn't responding**
Check your bot token and user ID, then run `sudo systemctl restart openclaw`

**Q. Nothing appears on screen when I type my password**
This is normal. SSH hides passwords for security. Just type and press Enter.

**Q. It stopped working after a server reboot**
Run `sudo systemctl enable openclaw` then try again.

**Q. Can I use a provider other than Anthropic?**
Yes — OpenClaw supports multiple LLM providers. See the [official docs](https://docs.openclaw.ai).

---

## 🌐 Korean Guide

한국어 가이드: [README.md](./README.md)

---

## ⭐ Star

If this helped you, please star the repo. Updates coming regularly.

---

*Originally by [@kokoju007](https://github.com/kokoju007) | Maintained by [Daehan-Base](https://github.com/Daehan-Base)*
