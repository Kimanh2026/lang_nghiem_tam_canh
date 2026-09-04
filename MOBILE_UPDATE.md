# Mobile layout update — 2026-09-04

- Below 600 logical pixels: full-width content, six bottom destinations, space for the Netlify badge.
- Desktop: retain the left navigation rail.
- Compact app bars; flexible progress heading; smaller chat margins and counter spacing.
- Original lotus photography hero; no reference-app images, logo, text, or source code copied.
- Preserve existing preferences, PIN, recitation count, chat history, and reminder functionality.
- HTTP revalidation headers for HTML and app entry scripts; no browser storage clearing.

## Asset provenance

Generated with the built-in image generation tool. File: `assets/images/lotus-dawn.png`.

Final prompt:

Create an original photorealistic wide 3:2 hero photograph for a Vietnamese Buddhist chanting application. A tranquil lotus pond at dawn, luminous ivory and soft pink lotus flowers in the right half, mist floating over dark olive water, distant subtle temple roof silhouette, warm amber morning sunlight. Left half has deep soft shadow and uncluttered negative space for cream colored UI text. Elegant contemplative natural photography, realistic petals and gentle reflections, refined brown gold muted green palette. No people, no text, no lettering, no logos, no watermarks. This is a landscape app background image, not a screenshot or UI mockup.

## Verification

`flutter test test/mobile_layout_test.dart test/notification_service_test.dart`: 7 tests passed. The layout tests switch through all six destinations at widths 320, 390, 430, and 1024.

Browser visual checks at 390 × 844: Home hero, Tiểu Tịnh composer, Trì chú counter, and author page. Not a physical iPhone/Safari test.

`flutter analyze`: 9 informational findings in existing logging/async-context code, no errors or warnings.
