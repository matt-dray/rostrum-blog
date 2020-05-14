# Creating a GitHub Twittercard
# See https://www.ddrive.no/post/making-hex-and-twittercard-with-bunny-and-magick/
# by Dmytro Perepolkin (@dmi3k)

# Attach packages
library(bunny)
library(magick)
library(dplyr)

# Image URLs
hex_path <- "https://raw.githubusercontent.com/matt-dray/stickers/master/output/rostrum_hex.png"
logo_path <- "https://raw.githubusercontent.com/matt-dray/rostrum-blog/master/static/images/logo.png"

# Read images
hex <- image_read(hex_path) %>% image_scale("400x400")
bug_logo <- image_read(logo_path) %>% image_scale("90x90")

# Specify card elements
# (There'll have been a better way to do this than copy-paste; sue me)
card <- image_canvas_ghcard("#000") %>% 
  # bug logo row 1
  image_compose(bug_logo) %>% 
  image_compose(bug_logo, offset = "+1000") %>% 
  image_compose(bug_logo, offset = "+2000") %>% 
  image_compose(bug_logo, offset = "+3000") %>% 
  image_compose(bug_logo, offset = "+4000") %>% 
  image_compose(bug_logo, offset = "+5000") %>% 
  image_compose(bug_logo, offset = "+6000") %>% 
  image_compose(bug_logo, offset = "+7000") %>% 
  image_compose(bug_logo, offset = "+8000") %>% 
  image_compose(bug_logo, offset = "+9000") %>% 
  image_compose(bug_logo, offset = "+10000") %>% 
  # bug logo row 2
  image_compose(bug_logo, offset = "+0+100") %>% 
  image_compose(bug_logo, offset = "+100+100") %>% 
  image_compose(bug_logo, offset = "+200+100") %>% 
  image_compose(bug_logo, offset = "+300+100") %>% 
  image_compose(bug_logo, offset = "+400+100") %>% 
  image_compose(bug_logo, offset = "+500+100") %>% 
  image_compose(bug_logo, offset = "+600+100") %>% 
  image_compose(bug_logo, offset = "+700+100") %>% 
  image_compose(bug_logo, offset = "+800+100") %>% 
  image_compose(bug_logo, offset = "+900+100") %>% 
  image_compose(bug_logo, offset = "+1000+100") %>% 
  # bug logo row 3
  image_compose(bug_logo, offset = "+0+200") %>% 
  image_compose(bug_logo, offset = "+100+200") %>% 
  image_compose(bug_logo, offset = "+200+200") %>% 
  image_compose(bug_logo, offset = "+300+200") %>% 
  image_compose(bug_logo, offset = "+400+200") %>% 
  image_compose(bug_logo, offset = "+500+200") %>% 
  image_compose(bug_logo, offset = "+600+200") %>% 
  image_compose(bug_logo, offset = "+700+200") %>% 
  image_compose(bug_logo, offset = "+800+200") %>% 
  image_compose(bug_logo, offset = "+900+200") %>% 
  image_compose(bug_logo, offset = "+1000+200") %>% 
  # bug logo row 4
  image_compose(bug_logo, offset = "+0+300") %>% 
  image_compose(bug_logo, offset = "+100+300") %>% 
  image_compose(bug_logo, offset = "+200+300") %>% 
  image_compose(bug_logo, offset = "+300+300") %>% 
  image_compose(bug_logo, offset = "+400+300") %>% 
  image_compose(bug_logo, offset = "+500+300") %>% 
  image_compose(bug_logo, offset = "+600+300") %>% 
  image_compose(bug_logo, offset = "+700+300") %>% 
  image_compose(bug_logo, offset = "+800+300") %>% 
  image_compose(bug_logo, offset = "+900+300") %>% 
  image_compose(bug_logo, offset = "+1000+300") %>% 
  # bug logo row 5
  image_compose(bug_logo, offset = "+0+400") %>% 
  image_compose(bug_logo, offset = "+100+400") %>% 
  image_compose(bug_logo, offset = "+200+400") %>% 
  image_compose(bug_logo, offset = "+300+400") %>% 
  image_compose(bug_logo, offset = "+400+400") %>% 
  image_compose(bug_logo, offset = "+500+400") %>% 
  image_compose(bug_logo, offset = "+600+400") %>% 
  image_compose(bug_logo, offset = "+700+400") %>% 
  image_compose(bug_logo, offset = "+800+400") %>% 
  image_compose(bug_logo, offset = "+900+400") %>% 
  image_compose(bug_logo, offset = "+1000+400") %>% 
  # blog hex sticker (central)
  image_compose(hex, gravity = "Center") %>% 
  # outer border
  image_border_ghcard("#000")

# Write the PNG somewhere
image_write(card, "~/Desktop/rostrum_ghcard.png")
