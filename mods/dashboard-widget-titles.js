// Dashboard Webpage Widget Custom Titles
// Vivaldi Browser Mod - Customizes webpage widget headers on the new tab dashboard
(function() {
  // Map of URL patterns to custom titles
  // Edit this object to add your own custom titles
  const customTitles = {
    'status.astronomyacres.com': 'AARO Status',
    // Add more mappings as needed, e.g.:
    // 'example.com': 'My Example Site',
  };

  function updateWidgetTitles() {
    document.querySelectorAll('.Dashboard-Webpage').forEach(widget => {
      const urlWrapper = widget.querySelector('.url-wrapper');
      const titleSpan = widget.querySelector('.dashboard-widget-header .title span');

      if (urlWrapper && titleSpan) {
        const urlText = urlWrapper.textContent || '';

        // Check for custom title mapping
        for (const [pattern, customTitle] of Object.entries(customTitles)) {
          if (urlText.includes(pattern)) {
            titleSpan.textContent = customTitle;
            urlWrapper.style.display = 'none';
            return;
          }
        }

        // Fallback: Extract just domain.tld from URL
        const match = urlText.match(/^(?:https?:\/\/)?([^\/]+)/);
        if (match) {
          titleSpan.textContent = match[1];
          urlWrapper.style.display = 'none';
        }
      }
    });
  }

  // Run on load and observe for changes
  const observer = new MutationObserver(updateWidgetTitles);

  function init() {
    updateWidgetTitles();
    const dashboard = document.querySelector('.Dashboard-Widgets');
    if (dashboard) {
      observer.observe(dashboard, { childList: true, subtree: true });
    }
  }

  // Wait for DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    setTimeout(init, 1000); // Delay for Vivaldi UI to fully load
  }
})();
