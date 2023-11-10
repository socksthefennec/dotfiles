{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        browser = {
          ctrlTab.sortByRecentlyUsed = true;
          newtabpage.activity-stream = {
            section.highlights = {
              includeBookmarks = false;
              includeDownloads = false;
              includePocket = false;
              includeVisited = false;
            };
            showSearch = false;
            showSponsoredTopSites = false;
            topSitesRows = 4;
          };
          search.suggest.enabled = false;
          sessionstore.warnOnQuit = true;
          tabs = {
            inTitlebar = 1;
            warnOnClose = true;
          };
          toolbars.bookmarks.visibility = "never";
        };
        devtools = {
          theme = "dark";
          toolbox.host = "window";
        };
        extensions.pocket.enabled = false;
        gfx.webrender.all = true;
        image.jxl.enabled = true;
        layout.css = {
          has-selector.enabled = true;
          scroll-driven-animations.enabled = true;
        };
        media.hardwaremediakeys.enabled = false;
        privacy.donottrackheader.enabled = true;
        toolkit.legacyUserProfileCustomizations.stylesheets = true;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        auto-tab-discard
        bitwarden
        clearurls
        consent-o-matic
        cookies-txt
        darkreader
        decentraleyes
        # not found: Don't accept image/webp
        # not found: Don't touch my tabs!
        enhancer-for-youtube
        # not found: FABUI
        facebook-container
        # not found: fastforward
        # fediact
        # not found: ffz
        # gnome-shell-integration
        image-search-options
        # plasma-integration
        privacy-badger
        privacy-possum
        pronoundb
        # reddit-enhancement-suite
        # not found: reddit masstagger
        # not found: redirect amp to html
        # not found: share to mastodon
        # not found: shinigami eyes
        # not found: simple translate
        # not found: smart https
        # not found: smartupscale
        # not found: steam url opener
        streetpass-for-mastodon
        stylus
        transparent-standalone-image
        ublock-origin
        # not found: up to 11
        view-image
      ];
      userChrome = ''
        /* make tabs and bar look nicer */
        :root {
          --tabs-box-shadow: 0 0 4px rgba(0,0,0,.4);
        }

        .browser-toolbar {
          --toolbar-bgcolor: -moz-dialog;
          box-shadow: unset !important;
        }

        .tab-background:is([selected], [multiselected]) {
          --tab-selected-bgcolor: -moz-dialog;
          box-shadow: var(--tabs-box-shadow) !important;
        }

        /* fancy statuspanel (the thing on the bottom left/right when you hover a link) styling */
        #statuspanel-label {
          background: -moz-dialog;
          border: none !important;
          margin: 0.5em !important;
          border-radius: 2em !important;
          padding: 0.5em !important;
          box-shadow: 0 2px 10px 2px #0007;
        }
      '';
      # userContent = '''';
      # extraConfig = '''';
      # search = {
      #   engines = {};
      #   default = "";
      #   order = {};
      # };
    };
  };
}
