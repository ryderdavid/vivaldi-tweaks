# Vivaldi Tweaks

Custom JavaScript mods for the Vivaldi browser.

## Mods Included

### dashboard-widget-titles.js

Cleans up webpage widget headers on the new tab dashboard. Instead of showing:
```
Title: status.astronomyacres.com
status.astronomyacres.com/popOut.html
```

It shows a clean custom title (e.g., "AARO Status") or just the domain name.

**Features:**
- Custom title mappings for specific URLs
- Falls back to showing just the domain (hides the URL path)
- Automatically observes DOM changes for dynamically loaded widgets

## Installation

Vivaldi's "Allow mods" setting only enables CSS mods. JavaScript mods require modifying `window.html` inside the Vivaldi app bundle.

### macOS Installation

1. **Quit Vivaldi completely**

2. **Find your Vivaldi version path:**
   ```
   /Applications/Vivaldi.app/Contents/Frameworks/Vivaldi Framework.framework/Versions/[VERSION]/Resources/vivaldi/
   ```
   Replace `[VERSION]` with your current version (e.g., `7.7.3851.61`)

3. **Create the mods folder:**
   ```bash
   mkdir -p "/Applications/Vivaldi.app/Contents/Frameworks/Vivaldi Framework.framework/Versions/[VERSION]/Resources/vivaldi/mods"
   ```

4. **Copy the JS file:**
   ```bash
   cp mods/dashboard-widget-titles.js "/Applications/Vivaldi.app/Contents/Frameworks/Vivaldi Framework.framework/Versions/[VERSION]/Resources/vivaldi/mods/"
   ```

5. **Edit window.html** at:
   ```
   /Applications/Vivaldi.app/Contents/Frameworks/Vivaldi Framework.framework/Versions/[VERSION]/Resources/vivaldi/window.html
   ```

   Add before `</body>`:
   ```html
   <script src="mods/dashboard-widget-titles.js"></script>
   ```

6. **Restart Vivaldi**

### After Vivaldi Updates

Vivaldi updates will overwrite `window.html` and remove the mods folder. You'll need to repeat steps 3-5 after each update.

## Customization

Edit the `customTitles` object in `dashboard-widget-titles.js`:

```javascript
const customTitles = {
  'status.astronomyacres.com': 'AARO Status',
  'example.com': 'My Example Site',
  'github.com': 'GitHub',
};
```

URLs without a custom mapping will display just the domain name.

## References

- [Awesome Vivaldi - macOS Installation](https://deepwiki.com/PaRr0tBoY/Awesome-Vivaldi/2.3.1-macos-installation-(upviv-script))
- Vivaldi stores CSS mods separately via the "Allow mods" setting, which loads from `chrome://vivaldi-data/css-mods/css`
