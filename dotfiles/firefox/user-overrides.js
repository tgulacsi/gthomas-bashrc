// user_pref("pref.name.example", "purple");
/*

There is no need to change any prefs - to keep some cookies and logins, just add site exceptions: either

    Ctrl+I > Permissions > Cookies > Allow (when on the website in question)
    ☰ Settings > Privacy & Security > Cookies & Site Data > Manage Exceptions

For cross-domain logins, add exceptions for both sites

    e.g. https://www.youtube.com (site) + https://accounts.google.com (single sign on)

*/


/* override recipe: enable session restore ***/
user_pref("browser.startup.page", 3); // 0102
user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
user_pref("privacy.clearOnShutdown.history", false); // 2811 FF127 or lower
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false); // 2811 FF128+

user_pref("dom.security.https_only_mode", false);

user_pref("privacy.resistFingerprinting.letterboxing", false);
user_pref("letterbox", false);
user_pref("privacy.window.maxInnerWidth", 3200);
user_pref("privacy.window.maxInnerHeight", 1800);

user_pref("webgl.disabled", false);
