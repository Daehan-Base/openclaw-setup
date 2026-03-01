# Contabo VPS Installation Guide (for OpenClaw)

This guide is written for users without development background, with short explanations of key terms.

⚠️ The Contabo user interface may change over time, so the actual UI may differ from the screenshots.

## First, terms you should know

- **VPS**: A virtual server you rent over the internet that runs 24/7.
- **IP Address**: The address used to connect to your VPS remotely.
- **SSH**: A secure way to connect to the VPS through a terminal.
- **root**: The default administrator account on the server. This guide uses root for the first connection.
- **CPU / RAM / SSD / NVMe**
  - CPU: Processing power of the server (more is generally faster).
  - RAM: Available memory for concurrent tasks.
  - SSD/NVMe: Storage types. NVMe is faster but usually smaller in capacity.
- **Region**: The physical location of the server. Nearby regions usually respond faster.
- **SSH key**: A login method using key files instead of a password (generally more secure).

## 1) Register and add a payment method for Contabo

1. Open Contabo and create an account.
2. Register a payment method.

## 2) Create a VPS (Cloud VPS 10)

Follow the screenshots in order.

1) On Contabo, click `View all Cloud VPS` from the main page
   ![1. Landing Webpage](./assets/imgs/00-landing-webpage.png)

2) Go to the `Cloud VPS` list and choose `Cloud VPS 10`
   ![2. Landing Cloud VPS](./assets/imgs/01-landing-cloud-vps.png)

3) Select `Cloud VPS 10` (4 vCPU / 8GB RAM / 75GB SSD)
   ![3. Select VPS 10](./assets/imgs/02-select-vps-10.png)

4) Configure base settings

- **4.1 Set the size**: Choose a subscription period of 1 / 6 / 12 months (1 month is usually a good start).
  - Region: Choose the lowest-latency region in the `Asia` tab (for example, Singapore / India / Japan).
  ![4. Setup VPS 10, CPU : term : Region](./assets/imgs/03-setup-vps-10-cpu-term-region.png)

- **4.2 OS and storage**
  - Choose either `150 SSD` or `75 NVMe`.
  - If storage size is more important, pick SSD. NVMe is faster but smaller.
  - `Image`: choose Ubuntu (a widely used and stable Linux distribution).
  - `Data Protection`: choose `No Data Protection`.
  ![5. Setup VPS 10, Storage : OS : Data Protection](./assets/imgs/04-setup-vps-10-storage-os-data-protection.png)

- **4.3 Set login information**
  - Set `username` to `root`.
  - Set `password` to be used later for SSH login.
  - Keep Network/Add-ons at default.
  - Note: this guide uses password login.
  ![6. Setup VPS 10, Networking : Add-Ons : Username & Password](./assets/imgs/05-setup-vps-10-networking-addons-username-password.png)

5) Proceed to payment
   - Check the latest amount shown on the payment screen.
   ![7. Pay for VPS](./assets/imgs/06-pay-for-vps.png)

6) Confirm creation completed
   ![8. Done](./assets/imgs/07-done.png)

7) Check VPS details from email
   - After creation, an email is sent with `IP Address` and `username`.
   - Use the IP Address to connect remotely.
   - Use the password set in step 4.3 for SSH login.
   - If the email is not found, confirm again in your inbox.
   ![9. Get VPS 10 Info](./assets/imgs/08-get-vps-10-info.png)

## 3) Connect to VPS with SSH

Use this command (replace `<IP Address>` with your VPS IP):

```bash
ssh root@<IP Address>
```

### 3-1) macOS / Linux

- Open Terminal (Terminal, iTerm, Warp, etc.)
- Run the command above and enter your password
- If a prompt appears, the connection is successful
- If it fails:
  - Check your password (it is normal if no characters appear while typing)
  - Check the IP and login information in your email again

![10. Access to VPS](./assets/imgs/09-access-to-vps.png)

### 3-2) Windows

- Enable SSH service in Windows first.
- Official guide: [Install the SSH service on a Windows computer](https://learn.microsoft.com/en-us/powershell/scripting/security/remoting/ssh-remoting-in-powershell?view=powershell-7.5#install-the-ssh-service-on-a-windows-computer)
- Open PowerShell and run:

```bash
ssh root@<IP Address>
```

- Enter your password and wait for the prompt.
- If connection fails, check password and email info again.

## 4) Optional: SSH key security

This guide uses password-based login.
Using an SSH key is safer and more convenient.

- Keep your private key on your local machine, and register only the public key on the server.
- You can log in without entering a password.
- Access without a registered key is blocked.
- Password exposure risk is reduced.

## 5) Run OpenClaw installation on the server

If you are not comfortable using command-line commands yet, it is recommended to first set up one AI coding assistant tool (for example Claude Code, Codex, Gemini CLI, or Cursor) and use it to run the steps below.

After SSH access is confirmed, run the following script step by step.  
This is written for a fresh server where the repository is not cloned yet.

```bash
# 1) If git is missing
# If you see this:
# command not found: git
# install git first:
sudo apt-get update
sudo apt-get install -y git

# 2) Clone this repository
git clone https://github.com/Daehan-Base/openclaw-setup.git

# 3) Enter the cloned directory
cd openclaw-setup

# 4) Install
bash install_en.sh
```

The script runs in this order:

- 1) Verify server environment (warns on non-Ubuntu OS, optional continue)
- 2) Check/install Node.js 22 (required minimum)
- 3) Install or update `openclaw` to the latest version
- 4) Collect Telegram bot token/user ID/Anthropic API key and apply non-interactive OpenClaw onboarding
- 5) Apply OpenClaw config (`gateway` + Telegram), register systemd service, and confirm running status

The installer sets up OpenClaw, Telegram bot connection, and service registration in one run.

---

*Made by [@ilevk](https://github.com/ilevk) (Based Devrel Ambassador) | Maintained by [Daehan-Base](https://github.com/Daehan-Base)*
