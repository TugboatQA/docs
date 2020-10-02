---
title: "How Lighthouse in Tugboat works"
date: 2019-09-19T10:32:20-04:00
weight: 4
---

When you build a Preview in Tugboat, Tugboat can run Lighthouse performance, accessibility, SEO, and best-practices
audits against URLs in your Tugboat Preview.

![Screenshots of Performance, Accessibility, and Best Practices Lighthouse reports run against Tugboat Preview pages](/_images/lighthouse-reports.png)

## What is Lighthouse?

Lighthouse is an open-source tool designed to audit web pages and make suggestions on how to improve key metrics.
Lighthouse is a developer tool created and maintained by Google. You can use it to identify accessibility, SEO,
performance, and best-practices issues, and correct them to improve scores across those metrics. When you run Lighthouse
against every Tugboat Preview, you can also use it to spot potential regressions before you merge code.

For more about Google Lighthouse, take a look at its documentation:
[Google Tools for Web Developers -> Lighthouse](https://developers.google.com/web/tools/lighthouse).

While Google Lighthouse is an open-source tool that you can manually run against Tugboat Previews, Tugboat's Lighthouse
integration automates this process, and integrates it with the additional tasks you can perform against your Tugboat
Previews. When you use Tugboat's Lighthouse integration to run your Lighthouse audits, you'll see a status message on
the linked git provider pull request showing whether the reports generated correctly, and providing a link to view the
reports

![Screenshots of Lighthouse reports link on GitHub PR](/_images/lighthouse-reports-on-github-pr.png)

You'll also be able to view a summary of the reports in the Tugboat Dashboard, and can click into the summary to view
more details.

![Screenshots of Lighthouse reports listed in Tugboat dashboard](/_images/lighthouse-reports-in-dashboard.png)

## What do Lighthouse reports measure?

Tugboat's Lighthouse integration uses the default Lighthouse config, which audits five groups of metrics:

- [Performance](#lighthouse-performance-audits-in-tugboat)
- [Accessibility](#lighthouse-accessibility-audits-in-tugboat)
- [Best Practices](#lighthouse-best-practices-audits-in-tugboat)
- [SEO](#lighthouse-seo-audits-in-tugboat)
- [Progressive Web App](#lighthouse-progressive-web-app-audits-in-tugboat)

However, because Tugboat runs on shared infrastructure, our configuration disables a few server performance metrics that
would not provide an accurate representation of your website or web app's performance.

If you'd prefer to audit other metrics, or disable or change thresholds for specific metrics, you can
[use a custom Lighthouse configuration](../configure-lighthouse-reports/#use-a-custom-lighthouse-configuration-file) in
your Tugboat Lighthouse integration.

For more on what these metrics mean, how they're scored, and how to address issues identified in Lighthouse reports,
see: [Lighthouse audit documentation](https://web.dev/learn/#lighthouse).

### Lighthouse Performance audits in Tugboat

![Screenshots of Lighthouse performance report](/_images/lighthouse-performance-report.png)

Lighthouse audits specific performance metrics to determine whether the page is optimized for users to quickly view and
interact with page content. Lighthouse performance reports include information on things like:

- First Contentful Paint
- Time to Interactive
- Opportunities to help the page load faster
- Diagnostic details related to performance

You can also view all of the audits that your web app or webpage has passed under the Passed Audits list.

![Screenshots of Lighthouse performance report passed metrics](/_images/lighthouse-performance-passed-audits.png)

For more on what Lighthouse performance metrics mean, how they're scored, and how to address issues identified in the
Lighthouse performance report, see:
[Lighthouse performance audit documentation](https://web.dev/lighthouse-performance/).

### Lighthouse Accessibility audits in Tugboat

![Screenshots of Lighthouse accessibility report](/_images/lighthouse-accessibility-report.png)

Lighthouse audits web apps and pages to automatically detect common accessibility issues. Lighthouse accessibility
reports include information on things like:

- Contrast ratios
- Names and labels
- Navigation
- ARIA
- Internationalization and localization
- Guidance on additional items to check manually in an accessibility review

You can also view all of the accessibility audits that your web app or webpage has passed under the Passed Audits list.

![Screenshots of Lighthouse accessibility audit's passed metrics](/_images/lighthouse-accessibility-passed-audits.png)

For more on what Lighthouse accessibility metrics mean, how they're scored, and how to address issues identified in the
Lighthouse accessibility report, see:
[Lighthouse accessibility audit documentation](https://web.dev/lighthouse-accessibility/).

### Lighthouse Best Practices audits in Tugboat

![Screenshot of Lighthouse best practices report](/_images/lighthouse-best-practices-report.png)

Lighthouse performs code health checks of your web app or webpage to help you improve the overall code health of your
project. Lighthouse best practice reports include information on things like:

- General best practices
- Improving page security and speed
- Creating a good user experience
- Avoiding deprecated technologies

You can also view all of the accessibility audits that your web app or webpage has passed under the Passed Audits list.

![Screenshot of Lighthouse best practices audit's passed metrics](/_images/lighthouse-best-practices-passed-audits.png)

For more on what Lighthouse best practices metrics mean, how they're scored, and how to address issues identified in the
Lighthouse best practices report, see:
[Lighthouse best practices audit documentation](https://web.dev/lighthouse-best-practices/).

### Lighthouse SEO audits in Tugboat

![Screenshot of Lighthouse SEO report](/_images/lighthouse-seo-report.png)

Lighthouse audits your webpages and web apps to determine whether your pages are optimized for good search engine
results performance. Lighthouse SEO reports include information on things like:

- Content best practices
- Whether search engines can crawl and index your pages
- Whether your pages are mobile-friendly
- Additional things you can check manually to improve your SEO

You can also view all of the SEO audits that your web app or webpage has passed under the Passed Audits list.

![Screenshot of Lighthouse SEO audit's passed metrics](/_images/lighthouse-seo-passed-audits.png)

For more on what Lighthouse SEO metrics mean, how they're scored, and how to address issues identified in the Lighthouse
SEO report, see: [Lighthouse SEO audit documentation](https://web.dev/lighthouse-seo/).

### Lighthouse Progressive Web App audits in Tugboat

![Screenshot of Lighthouse progressive web app report](/_images/lighthouse-progressive-web-app-report.png)

Lighthouse audits progressive web apps to validate common issues and confirm your progressive web app is fast, reliable,
and installable. Lighthouse PWA audits check for things like:

- Whether your progressive web app is fast and reliable
- Is your PWA installable?
- Whether your PWA is optimized
- Guidance on additional items to check manually

For more on what Lighthouse progressive web app metrics mean, how they're scored, and how to address issues identified
in the Lighthouse PWA report, see:
[Lighthouse progressive web app audit documentation](https://web.dev/lighthouse-pwa/).
