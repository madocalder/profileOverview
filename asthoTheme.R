#STYLES -----------------
## set colors --------------------------------------------------------------

###define colors-------------------------------------------------------
main_blue <- "#005182"
light_blue <- "#70C4E8"
main_orange <- "#C65227"
dark_orange <- "#90361F"
main_yellow <- "#EBB41F"
light_yellow <- "#FFD780"
NA_color <- "#E6E1E7"
dark_accent <- "#242c3d"
light_accent <- "#cae6f2"
icon_accent <- "#47BA83"
main_colors <- c(light_blue, main_orange, main_yellow, icon_accent, main_blue)
dark_main_colors <- c("#D86B45","#15395A","#325F87", "#A67B05","#287E58" ) #these are for bubble

###gov colors --------------------------------------------------------
gov_color_2 <- c(main_blue, main_orange)
gov_color_3 <- c(light_yellow, main_yellow, main_orange)
gov_color_4 <- c(main_yellow, main_blue, light_blue, main_orange)
gov_color_5 <- c(light_blue, main_orange, main_blue, icon_accent, main_yellow)
gov_oranges <- c(light_yellow, main_yellow,main_orange,dark_orange)

###structure colors --------------------------------------------------
struct_base <- c(main_orange, main_blue)
struct_color_3 <-c(light_blue, light_accent, NA_color)
struct_color_2 <-c(light_blue, NA_color)


# define visualization theme ----------------------------------------------

astho_theme <- hc_theme(
  colors = main_colors,
  chart = list(
    backgroundColor = "white"
  ),
  style = list(
    fontFamily = "Jost"
  ),
  title = list(
    style = list(
      color = dark_accent,
      fontFamily = "Jost",
      fontWeight = "500",
      fontSize = "20px"
    )
  ),
  subtitle = list(
    style = list(
      color = dark_accent,
      fontFamily = "Jost",
      fontSize = "14px"
    )
  ),
  caption = list(
    style = list(
      color = "#7e7f7f",
      fontFamily = "Jost",
      fontSize = "12px"
    )
  ),
  xAxis = list(
    labels = list(
      style = list(
        fontFamily = "Jost",
        fontSize = "15px",  # Adjusted to be consistent with yAxis labels
        fontWeight = "normal",
        color = "#666"
      )
    ),
    title = list(
      style = list(
        color = dark_accent,
        fontFamily = "Jost",
        fontWeight = "500",
        fontSize = "15px"
      )
    )
  ),
  yAxis = list(
    labels = list(
      style = list(
        fontFamily = "Jost",
        fontSize = "15px",  # Adjusted to be consistent with xAxis labels
        fontWeight = "normal",
        color = "#666"
      )
    ),
    title = list(
      style = list(
        color = dark_accent,
        fontFamily = "Jost",
        fontWeight = "500",
        fontSize = "15px"
      )
    )
  ),
  legend = list(
    itemStyle = list(
      fontFamily = "Jost",
      color = dark_accent,
      fontSize = "17px",
      fontWeight = "normal"
    ),
    title = list(
      style = list(
        textDecoration = "none",
        fontFamily = "Jost",
        fontSize = "16px"
      )
    )
  ),
  tooltip = list(
    padding = 10,
    borderRadius = 20,
    backgroundColor = "#fff",
    style = list(
      fontFamily = "Jost",
      fontSize = "14px")
  )
)




