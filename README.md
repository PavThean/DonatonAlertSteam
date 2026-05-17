# 🚀 ABA Donation Stream Alert Setup Guide
Thank you for purchasing **ABA Donation Stream Alert** by **PavThean Creator**. Follow this quick guide to set up your automated live stream overlay with optional AI features.

---

## 📋 Prerequisites Before Starting
Make sure you have your Telegram API credentials ready. If you don't have them yet:
1. Go to [https://my.telegram.org/apps](https://my.telegram.org/apps) and log in with your phone number.
2. Create a new application (fill in any app title and short name).
3. Copy your unique **`api_id`** (numbers) and **`api_hash`** (letters/numbers string).

### 🤖 Optional: Anthropic Claude AI Key (For AI Voice Alerts)
If you want the alert system to generate unique, dynamic, and enthusiastic AI read-outs based on the donor's name and remarks using Claude:
1. Create an account at [https://console.anthropic.com/](https://console.anthropic.com/).
2. Generate an API Key from your account dashboard.
3. Keep this key handy during the setup stage below. If you don't have one, you can skip it; standard audio triggers and alerts will still work perfectly.

---

## 🛠️ Step 1: Initial Setup
1. Extract the provided `.zip` folder to a permanent location on your computer.
2. Double-click and run **`Start.bat`**.
3. **Activate License:** Paste the `license.key` provided to you by the developer when prompted.
4. **Link Telegram:**
   * Enter your `api_id` and `api_hash` when requested.
   * Input your Telegram phone number (include international format, e.g., `+855xxxxxxx`).
   * Enter the **OTP confirmation code** sent to your Telegram app.
   * *(Optional)* If your account has Two-Factor Authentication enabled, type your 2FA password.
5. **Add AI Feature (Optional):** When prompted for the `anthropicApiKey`, paste your text key starting with `sk-ant-...`. If you do not wish to use the AI generator, press **Enter** to skip.

Once setup completes, the terminal will lock in and display: 
`✅ Listening for ABA donations...`

> 💡 **Manual Update Tip:** If you skip this during setup and want to add or change your AI key later, you can open `telegram.config.json` in a text editor and paste your key inside the `"anthropicApiKey": ""` field, or update it directly from the advanced settings tab inside the Web Dashboard. IT OPTIONAL IF YOU WANT USE AI TO READ DONATION.

---

## 🎛️ Step 2: Accessing Your Dashboard
Once the server is running, open your web browser and navigate to:
👉 **[http://localhost:3000](http://localhost:3000)**

From this control panel, you can:
* Customize alert templates, text formatting, and audio triggers.
* Toggle the **AI Voice / Read-out** feature on or off (requires the Anthropic Key).
* Adjust target goal amounts and manage your leaderboard widgets.
* Test alert configurations instantly using the **Test Alert** mechanism.

---

## 📺 Step 3: Integrating Overlays into OBS / Streamlabs
To show your donation alerts, goals, or leaderboards live on stream, add them as **Browser Sources** inside your streaming software:

### 🚨 1. Live Donation Alert Overlay
* **URL:** `http://localhost:3000/alert.html`
* **Width:** `1920` 
* **Height:** `1080`

### 🎯 2. Donation Goal Tracker Widget
* **URL:** `http://localhost:3000/goal-widget.html`
* **Width:** `540`
* **Height:** `200`

### 🏆 3. Top Donors Leaderboard Widget
* **URL:** `http://localhost:3000/top-widget.html`
* **Width:** `400`
* **Height:** `600`

> ⚠️ **OBS Configuration Tip:** Ensure the **"Refresh browser when scene becomes active"** option is checked in your Browser Source properties for optimal stability.

---

## 🔒 Important Security Notes
* **Do not share your `license.key`:** Your license configuration is bound securely to your hardware signature profile. Sharing it will automatically suspend authentication.
* **Keep your keys private:** Your `telegram.config.json` holds sensitive security sessions and API keys. Keep this file confidential.
* **Keep the console open:** The stream alerts rely entirely on the background command window. Closing the terminal or shutting down `Start.bat` will pause tracking operations immediately.

***
*Developed & Maintained by PavThean Creator. All rights reserved.*