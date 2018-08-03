# rostrum-blog

<img src="https://raw.githubusercontent.com/matt-dray/stickers/master/output/rostrum_hex.png" alt="Hexagonal sticker with the Rostrum logo on it" width="20%">

## What?

Hello and welcome to the source files for [rostrum.blog](https://www.rostrum.blog/) by Matt and Adriana. Learn more about the blog on the [About](https://www.rostrum.blog/about/) page.

## Site construction

The site was generated with the [blogdown](https://bookdown.org/yihui/blogdown/) package from the mighty [Yihui Xie](https://yihui.name/en/).

We used the Hugo Lithium Theme forked from [\@jrutheiser/hugo-lithium-theme](https://github.com/jrutheiser/hugo-lithium-theme) and modified by the legendary [Yihui Xie](https://github.com/yihui/hugo-lithium-theme).

The site is hosted with [Netlify](https://www.netlify.com/).

## For authors

### Process

1. `git clone https://github.com/matt-dray/rostrum-blog.git`
2. Open `rostrum-blog.Rproj` in RStudio
3. Go to Addins > New Post (assumes `blogdown` is installed)
4. In the pop-up, complete the title, author, categories and tags (choose from existing ones where possible; the Lithium theme doesn't yet have support for displaying tags and categories in their own pages, but fill this in anyway because we might sort it out in future)
5. Select 'R Markdown (.Rmd)' radio button
6. Write your post (add `draft: true` to the YAML while in draft)
7. For images, go to Addins > Add image (defaults to 100% page width when rendered)
8. `git commit` and `git push` as required
9. Go to Addins > Serve site and the site while render to the viewer (view in-browser with the 'Show in new window' button in the viewer menu)
10. When ready: remove `draft: true` from the YAML; Addins > Serve site; `commit` and `push`

### Theory

* New .Rmd posts are added to content > post
* Serving the site renders the .html and adds static files (images) to static > post
* Pushing to GitHub triggers Netlify to recognise the changes and render the site
