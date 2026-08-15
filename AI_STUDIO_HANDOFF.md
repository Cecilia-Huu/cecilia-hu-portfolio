# Cecilia Portfolio — Google AI Studio Handoff

Snapshot date: 2026-08-14

## Source of truth

`index.html` is the complete and latest website implementation. It is a single-file React 18 + Tailwind CDN website; JSX is compiled in the browser with Babel. The `assets/` paths listed below are the production assets currently referenced by the page.

Do not use earlier code snippets or previous chat drafts as the current state. If they conflict with `index.html`, `index.html` wins.

## Critical editing rules

1. Preserve the current Navbar, shared typography, colors, spacing system, responsive behavior, and all sections not explicitly named in the new request.
2. When asked to change one section, edit only its existing function: `HomeLarryStyle`, `EducationSection`, `ExperienceSection`, `ProjectsSection`, `SkillsSection`, or `ContactMenu`.
3. Do not create a second version of a section and do not duplicate content below the existing section.
4. Do not rename, redraw, imitate, or alter the internal UI of supplied product screenshots. Only presentation-layer treatments such as size, crop, radius, shadow, overlap, and object position are allowed.
5. Keep all existing asset paths working. Any new asset must be placed under `assets/` and referenced with a relative path.
6. Before changing code, state which function will be modified and confirm that all other sections will remain untouched.
7. After changing code, return the complete updated `index.html` or a precise replacement for the named function. Never answer with a vague mockup that cannot run.

## Current website structure

- `App()` controls the five tabs and the AI matcher modal.
- `ContactMenu()` provides the Navbar `Let’s Talk` popover with Email, LinkedIn, and WeChat copy interactions.
- `HomeLarryStyle()` contains Cecilia’s Home hero and must not be changed unless explicitly requested.
- `EducationSection()` contains the tiny-planet education composition and four-school information list.
- `ExperienceSection()` contains four experience cards.
- `ProjectsSection()` uses the real 吃啥 and 赛道测测 screenshots.
- `SkillsSection()` uses a centered warm apricot canvas tote rendered as a back layer plus a clipped foreground body mask. Notebook, laptop, cream APM-style over-ear headphones, and passport sit between those layers so their lower portions are physically occluded by the bag. The default state shows only PRODUCT, DATA, AI, and INTERNATIONAL; hovering, focusing, or tapping lifts the selected object slightly and reveals its full skill group.

## Current contact information

- Email: `hmxdxyx@163.com`
- LinkedIn: `https://www.linkedin.com/in/minxue-hu-986b5a38b`
- WeChat: `cecilia1205hmx`

## Production asset manifest

- `assets/cecilia-home-cutout.png`
- `assets/education-tiny-planet-circular.png`
- `assets/cecilia-education-cutout-v4-natural.png`
- `assets/calio-30-day-challenge.png`
- `assets/bytedance-hr-workshop.png`
- `assets/chisha-home.png`
- `assets/chisha-result.png`
- `assets/saidao-home.png`
- `assets/saidao-result.png`
- `assets/wechat-contact-icon.png`
- `assets/skills/cecilia-tote.png`
- `assets/skills/product-notebook.png`
- `assets/skills/data-laptop.png`
- `assets/skills/ai-headphones-apm.png`
- `assets/skills/global-passport.png`

## Recommended first message to Google AI Studio

I am uploading the latest authoritative snapshot of Cecilia Hu’s personal portfolio. Read `AI_STUDIO_HANDOFF.md` first, then read the complete `index.html`, and inspect the supplied assets. This snapshot replaces all older versions and previous code discussions. Do not modify anything yet. First summarize the current implementation section by section, identify the exact function responsible for each section, and confirm that future requests will modify only the explicitly named function while preserving every other section and the Navbar. When I provide the next design request, work directly from this snapshot rather than recreating the site.

## What to attach for later visual discussions

For each new visual discussion, attach one fresh screenshot of the current section plus any target reference image. Label them clearly as `CURRENT` and `TARGET`. Also say which function may be edited and which sections are locked.
