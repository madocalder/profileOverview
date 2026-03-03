# # 01. load packages and data -----
# library(readxl)
# library(magrittr)
# library(tidyverse)
# library(highcharter)
# library(tidytext)
# library(stringr)
# library(wordcloud)
# library(ggplot2)
# library(widyr)
#
#
#
#
#
# slidoResults <- read_excel("slidoResults.xlsx",
#                            col_types = c("text", "text", "text",
#                                          "text", "text", "numeric", "numeric",
#                                          "numeric", "text"))
# View(slidoResults)
#
# theme_data <- read_excel("themes.xlsx") %>%
#   janitor::clean_names() %>%  # Standardize column names
#   mutate(
#     poll_id = tolower(poll_id),  # Ensure consistent case
#
#     # Add missing theme columns with default FALSE values
#     color = ifelse("color" %in% names(.), color, FALSE),
#     readability = ifelse("readability" %in% names(.), readability, FALSE),
#     usability = ifelse("usability" %in% names(.), usability, FALSE),
#     relevance = ifelse("relevance" %in% names(.), relevance, FALSE),
#     feeling = ifelse("feeling" %in% names(.), feeling, FALSE),
#     style = ifelse("style" %in% names(.), style, FALSE),
#     desire = ifelse("desire" %in% names(.), desire, FALSE)
#   )
#
#
#
#
#
# # 02. load themes, etc. ------
# main_blue <- "#005182"
# light_blue <- "#70C4E8"
# main_orange <- "#C65227"
# dark_orange <- "#90361F"
# main_yellow <- "#EBB41F"
# light_yellow <- "#FFD780"
# NA_color <- "#E6E1E7"
# dark_accent <- "#242c3d"
# light_accent <- "#cae6f2"
# icon_accent <- "#47BA83"
# main_colors <- c(light_blue, main_orange, main_yellow, icon_accent, main_blue)
# dark_main_colors <- c("#325F87","#D86B45", "#A67B05","#287E58", "#15395A") #these are for bubble
#
# astho_theme <- hc_theme(
#   colors = main_colors,
#   chart = list(
#     backgroundColor = NULL),
#   # style = list(
#   #   color = dark_accent,
#   #   fontFamily = "Jost",
#   #   fontWeight = "500",
#   #   fontSize = "15px")),
#   style = list(
#     fontFamily = "Jost"),
#   title = list(
#     style = list(
#       color = dark_accent,
#       fontFamily = "Jost",
#       fontWeight = "bold",
#       fontSize = "18px")),
#   subtitle = list(
#     style = list(
#       color = dark_accent,
#       fontFamily = "Jost",
#       fontSize = "14px")),
#   caption = list(
#     style = list(
#       color = "#666",
#       fontFamily = "Jost",
#       fontSize = "13px")),
#   xAxis = list(
#     labels = list(
#       style = list(
#         fontFamily = "Jost",
#         fontSize = "15px",
#         fontWeight = "normal",
#         color = "#666")),
#     title = list(
#       style = list(
#         color = dark_accent,
#         fontFamily = "Jost",
#         fontWeight = "500",
#         fontSize = "15px"))),
#   yAxis = list(
#     labels = list(
#       style = list(
#         fontFamily = "Jost",
#         fontSize = "15px",
#         fontWeight = "normal",
#         color = "#666")),
#     title = list(
#       style = list(
#         color = dark_accent,
#         fontFamily = "Jost",
#         fontWeight = "500",
#         fontSize = "15px"))),
#   legend = list(
#     itemStyle = list(
#       fontFamily = "Jost",
#       color = dark_accent,
#       fontSize = "17px",
#       fontWeight = "normal",
#       color = "#666"),
#     title = list(
#       style = list(
#         textDecoration = "underline",
#         fontFamily = "Jost",
#         fontSize = "16px"))),
#   tooltip = list(
#     padding = 10,
#     borderRadius = 20,
#     backgroundColor = "#fff",
#     style = list(
#       fontFamily = "Jost",
#       fontSize = "14px",
#       maxWidth = "50%",
#       whiteSpace = "normal")),
#   useHTML = TRUE,
#   itemHoverStyle = list(
#     color = light_accent)
# ) #end of code for the astho theme
#
# # 03. cleaning/analysis -----
#
# ## Q1: Describe your current mood using one emoji -----
#
# q1 <- slidoResults %>%
#   dplyr::filter(`Poll ID` == "A")
#
# ## Q2: Profile/Scan data and product familiarity -----
#
# q2 <- slidoResults %>%
#   dplyr::filter(`Poll ID` == "B")%>%
#   dplyr::mutate(Percentage = (Count/`Total Votes`)*100)
#
# familiarity <- q2 %>%
#   hchart("pie", hcaes(x = `Poll Option`, y = Percentage)) %>%
#   hc_title(text = "Familiarity with Profile/Scan Data & Products <br> (n = 21)") %>%
#   # hc_chart(height = '100%') %>%
#   hc_chart(crop = FALSE) %>%
#   hc_plotOptions(
#     pie = list(
#       innerSize = "70%", # Set the inner size for the donut effect
#       allowPointSelect = TRUE, # Enable point selection on the chart
#       cursor = "pointer", # Set cursor style for selectable points
#       dataLabels = list(
#         enabled = TRUE,
#         format = "{point.percentage:.0f}% ",
#         distance = "15%",
#         style = list(
#           fontFamily = "Jost",
#           fontSize = "14px"
#         ),
#         connectorWidth = 3,  # Adjust this value to make the line thicker
#         connectorShape = 'fixedOffset'
#       ),
#       showInLegend = TRUE # Show legend for the chart
#     )
#   ) %>%
#   hc_tooltip(
#     useHTML = TRUE,
#     headerFormat = "{point.x}",
#     pointFormat = "When asked abut the Profile and Scan datasets and associated products, {point.percentage:.0f}% of accred. coordinators reported that they were {point.tt}. ",
#     shadow = FALSE,
#     borderWidth = 1,
#     hideDelay = 1200,
#     backgroundColor = "#fff",
#     style = list(
#       fontFamily = "Jost",
#       fontSize = "18px"
#     )
#   ) %>%
#   hc_legend(enabled = TRUE) %>%  # Enable the legend explicitly
#   hc_add_theme(astho_theme)
#
# familiarity
#
#
#
#
# ## Q3: Feature Appeal Ranking -----
#
# q3 <- slidoResults %>%
#   dplyr::filter(`Poll ID` == "C")%>%
#   arrange(desc(Results))
#
#
#
# feature_rank <- hchart(
#     q3,
#     "bar",
#     hcaes(x = `Poll Option`, y = Results)
#   ) %>%
#   hc_title(
#     text = "Average Feature Ranking (n = 23)"
#   ) %>%
#
#   hc_tooltip(
#     useHTML = TRUE,
#     headerFormat = "",
#     pointFormat = "
#       <b>Average ranking:</b> {point.y:.2f} <br>
#     ",
#     style = list(
#       fontSize = "14px"
#     )
#   ) %>%
#   hc_add_theme(astho_theme)
#
# feature_rank
#
# ## Q4: Blueprint Wireframe Reactions -----
#
# q4 <- slidoResults %>%
#   dplyr::filter(`Poll ID` == "D")%>%
#   arrange(desc(Results))
#
#
# ### 1. Read and Prepare Data --------------------------------
#
# # MODIFIED: Use standardized column names
# theme_data_d <- theme_data %>%
#   filter(poll_id == "d") %>%  # Use lowercase to match cleaned data
#   mutate(response_id = row_number())
#
# # Check available columns
# print("Columns in theme_data_d:")
# print(colnames(theme_data_d))
#
# # Check if theme columns exist
# theme_cols <- c("color", "readability", "usability", "relevance", "feeling", "style", "desire")
# print("Missing theme columns:")
# print(setdiff(theme_cols, colnames(theme_data_d)))
#
# # MODIFIED: Use cleaned column names in pivot
# long_data_d <- theme_data_d %>%
#   pivot_longer(
#     cols = c(color, readability, usability, relevance, feeling, style, desire),
#     names_to = "theme",
#     values_to = "flag"
#   ) %>%
#   filter(flag == TRUE) %>%  # Use TRUE instead of 1 for logical values
#   select(-flag)
#
#
#
# ### 2. Sentiment Analysis ----------------------------------
# # Get sentiment scores
# sentiments_d <- long_data_d %>%
#   unnest_tokens(word, phrase, token = "words") %>%
#   inner_join(afinn, by = "word") %>%
#   group_by(response_id, theme) %>%
#   reframe(sentiment = mean(value), word = word)
#
# # Join back to main data
# theme_data_d <- long_data_d %>%
#   left_join(sentiments_d, by = c("response_id", "theme"))%>%
#   dplyr::mutate()
#
# ### 3. Theme Frequency Analysis -----------------------------
# word_counts_d <- long_data_d %>%
#   unnest_tokens(word, phrase, token = "words") %>%
#   anti_join(stop_words) %>%
#   inner_join(parts_of_speech, relationship = "many-to-many") %>%
#   filter(pos %in% c("Adjective") ) %>%
#   group_by(word) %>%
#   count(word, name = "count") %>%
#   filter(word != "read") %>%
#   mutate(word = case_when(word == "overwhelming" ~ "not overwhelming",
#                           TRUE ~ word)) %>%
#   arrange(desc(count))
#
#
# word_cloud_d <- hchart(word_counts_d, "wordcloud",
#                        hcaes(name = word, weight = count)) %>%
#   hc_add_theme(astho_theme) %>%
#   hc_plotOptions(
#     series = list(
#       tooltip = list(pointFormat = "<b>{point.word}</b>: {point.n} mentions")
#     )
#   )
#
# word_cloud_d
#
# #bubble chart
# responses_d <- q4 %>% select(`Poll Option`)  # Extract the relevant column
#
# tidy_data_d <- responses_d %>%
#   unnest_tokens(word, `Poll Option`) %>%
#   anti_join(stop_words) %>%          # Remove common stopwords (e.g., "the", "and")
#   filter(!str_detect(word, "\\d+"))   # Remove numbers
#
#
# sentiments_d <- tidy_data_d %>%
#   inner_join(bing) %>%  # Join with sentiment lexicon
#   count(sentiment, word, sort = TRUE)
#
# # sentiment_scores <- responses_d %>%
# #   unnest_tokens(word, `Poll Option`) %>%
# #   inner_join(afinn) %>%
# #   group_by(sentiment) %>%
# #   summarise(sentiment = mean(value))
#
#
# blueprint_sentiments <- hchart(sentiments_d,
#                                "packedbubble",
#                                hcaes(name = word, value = log(n), group = sentiment)
# ) %>%
#   hc_add_theme(astho_theme) %>%
#   hc_tooltip(
#     useHTML = TRUE,
#     pointFormat = "<b>{point.name}"
#   ) %>%
#   hc_plotOptions(
#     packedbubble = list(
#       maxSize = "125%",
#       # zMin = 0,
#       layoutAlgorithm = list(
#         gravitationalConstant =  0.01,
#         splitSeries =  TRUE # TRUE to group points
#         # seriesInteraction = TRUE,
#         # dragBetweenSeries = TRUE,
#         # parentNodeLimit = TRUE
#       ),
#       dataLabels = list(
#         enabled = TRUE,
#         format = "{point.name}",
#         # ,
#         # filter = list(
#         #   property = "y",
#         #   operator = ">",
#         #   value = q95
#         # ),
#         style = list(
#           color = "black",
#           textOutline = "none",
#           fontWeight = "normal"
#         )
#       )
#     )
#   )
#
#
# blueprint_sentiments
#
# # sentiment by theme
#
# ### 1. Read and Prepare Data --------------------------------
# # Read tab-delimited theme data
# theme_data_d <- theme_data_d%>%
#   mutate(response_id = row_number())  # Add unique response ID
#
# # Reshape to long format for analysis
# long_data_d <- theme_data_d %>%
#   pivot_longer(
#     cols = c(Color, Readability, Usability, Relevance, Feeling, Style, Desire),
#     names_to = "theme",
#     values_to = "flag"
#   ) %>%
#   filter(flag == 1) %>%  # Keep only theme flags
#   select(-flag)
#
#
#
# ### 2. Sentiment Analysis ----------------------------------
# # Get sentiment scores
# sentiments_d <- long_data_d %>%
#   unnest_tokens(word, phrase, token = "words") %>%
#   inner_join(afinn, by = "word") %>%
#   group_by(response_id, theme) %>%
#   reframe(sentiment = mean(value), word = word)
#
# # Join back to main data
# theme_data_d <- long_data_d %>%
#   left_join(sentiments_d, by = c("response_id", "theme"))%>%
#   dplyr::mutate()
#
#
#
# colors <- c(main_colors, dark_orange)
#
#
#
# # Visualization 2: Sentiment by Theme
# sentiment_chart_d <- theme_data_d %>%
#   group_by(theme) %>%
#   filter(!(theme %in% c("Relevance", "Desire"))) %>%
#   summarise(avg_sentiment = mean(sentiment, na.rm = TRUE)) %>%
#   arrange(desc(avg_sentiment))  %>%
#   drop_na(avg_sentiment) %>%
#   hchart("column", hcaes(x = theme, y = avg_sentiment))%>%
#   hc_add_theme(astho_theme) %>%
#   hc_title(text = "Average Sentiment by Theme") %>%
#   hc_yAxis(title = list(text = "AFINN Sentiment Score")) %>%
#   hc_xAxis(title = "",
#            labels = list(enabled = TRUE)) %>%
#   hc_tooltip(pointFormat = "Avg. Sentiment: {point.y:.2f}") %>%
#   hc_colors(colors)
#
# sentiment_chart_d
#
# ## Q5: Profile Dash Landing Page Reactions -----
#
# q5 <- slidoResults %>%
#   dplyr::filter(`Poll ID` == "E")
#
# ## Profile Dash Landing Feedback
# ### 1. Read and Prepare Data --------------------------------
# # Read tab-delimited theme data
#
# # MODIFIED: Repeat same fixes for Q5
# theme_data_e <- theme_data %>%
#   filter(poll_id == "e") %>%
#   mutate(response_id = row_number())
#
# long_data_e <- theme_data_e %>%
#   pivot_longer(
#     cols = c(color, readability, usability, relevance, feeling, style, desire),
#     names_to = "theme",
#     values_to = "flag"
#   ) %>%
#   filter(flag == TRUE) %>%
#   select(-flag)
#
#
# ### 2. Sentiment Analysis ----------------------------------
# # Get sentiment scores
# sentiments_e <- long_data_e %>%
#   unnest_tokens(word, phrase, token = "words") %>%
#   inner_join(afinn, by = "word") %>%
#   group_by(response_id, theme) %>%
#   reframe(sentiment = mean(value), word = word)
#
# # Join back to main data
# theme_data_e <- long_data_e %>%
#   left_join(sentiments_e, by = c("response_id", "theme"))%>%
#   dplyr::mutate()
#
# ### 3. Theme Frequency Analysis -----------------------------
# word_counts_e <- long_data_e %>%
#   unnest_tokens(word, phrase, token = "words") %>%
#   anti_join(stop_words) %>%
#   inner_join(parts_of_speech, relationship = "many-to-many") %>%
#   filter(pos %in% c("Adjective") ) %>%
#   mutate(word = case_when(word == "easier" ~ "easy",
#                           TRUE ~ word)) %>%
#   group_by(word) %>%
#   count(word, name = "count") %>%
#   filter(!(word %in% c("read", "bottom", "related", "half", "prominent"))) %>%
#   mutate(word = case_when(word == "white" ~ "white space",
#                           word == "bigger" ~ "bigger font",
#
#                           TRUE ~ word)) %>%
#   arrange(desc(count))
#
#
#
# word_cloud_e <- hchart(word_counts_e, "wordcloud",
#                        hcaes(name = word, weight = count)) %>%
#   hc_add_theme(astho_theme)
#
#
# word_cloud_e
#
# #bubble chart
# responses_e <- q5 %>% select(`Poll Option`)  # Extract the relevant column
#
# tidy_data_e <- responses_e %>%
#   unnest_tokens(word, `Poll Option`) %>%
#   anti_join(stop_words) %>%          # Remove common stopwords (e.g., "the", "and")
#   filter(!str_detect(word, "\\d+"))   # Remove numbers
#
#
# sentiments_e <- tidy_data_e %>%
#
#   inner_join(bing) %>%  # Join with sentiment lexicon
#   mutate(word = case_when(word == "overwhelming" ~ "not overwhelming",
#                           TRUE ~ word),
#          sentiment = case_when(word == "not overwhelming" ~ "positive",
#          TRUE ~ sentiment)
#   ) %>%
#   mutate(word = case_when(word == "easier" ~ "easy",
#                           TRUE ~ word)) %>%
#   count(sentiment, word, sort = TRUE)
#
# # sentiment_scores <- responses_d %>%
# #   unnest_tokens(word, `Poll Option`) %>%
# #   inner_join(afinn) %>%
# #   group_by(sentiment) %>%
# #   summarise(sentiment = mean(value))
#
#
# dash_sentiments <- hchart(sentiments_e,
#                                "packedbubble",
#                                hcaes(name = word, value = log(n), group = sentiment)
# ) %>%
#   hc_add_theme(astho_theme) %>%
#   hc_tooltip(
#     useHTML = TRUE,
#     pointFormat = "<b>{point.name}"
#   ) %>%
#   hc_plotOptions(
#     packedbubble = list(
#       maxSize = "125%",
#       # zMin = 0,
#       layoutAlgorithm = list(
#         gravitationalConstant =  0.01,
#         splitSeries =  TRUE # TRUE to group points
#         # seriesInteraction = TRUE,
#         # dragBetweenSeries = TRUE,
#         # parentNodeLimit = TRUE
#       ),
#       dataLabels = list(
#         enabled = TRUE,
#         format = "{point.name}",
#         # ,
#         # filter = list(
#         #   property = "y",
#         #   operator = ">",
#         #   value = q95
#         # ),
#         style = list(
#           color = "black",
#           textOutline = "none",
#           fontWeight = "normal"
#         )
#       )
#     )
#   )
#
#
# dash_sentiments
#
# # sentiment by theme
#
# ### 1. Read and Prepare Data --------------------------------
# # Read tab-delimited theme data
# theme_data_e <- theme_data_e%>%
#   mutate(response_id = row_number())  # Add unique response ID
#
# # Reshape to long format for analysis
# long_data_e <- theme_data_e %>%
#   pivot_longer(
#     cols = c(Color, Readability, Usability, Relevance, Feeling, Style, Desire),
#     names_to = "theme",
#     values_to = "flag"
#   ) %>%
#   filter(flag == 1) %>%  # Keep only theme flags
#   select(-flag)
#
#
#
# ### 2. Sentiment Analysis ----------------------------------
# # Get sentiment scores
# sentiments_e <- long_data_e %>%
#   unnest_tokens(word, phrase, token = "words") %>%
#   inner_join(afinn, by = "word") %>%
#   group_by(response_id, theme) %>%
#   reframe(sentiment = mean(value), word = word)
#
# # Join back to main data
# theme_data_e <- long_data_e %>%
#   left_join(sentiments_e, by = c("response_id", "theme"))%>%
#   dplyr::mutate()
#
#
#
# colors <- c(main_colors, dark_orange)
#
#
#
# # Visualization 2: Sentiment by Theme
# sentiment_chart_e <- theme_data_e %>%
#   group_by(theme) %>%
#   filter(!(theme %in% c("Relevance", "Desire"))) %>%
#   summarise(avg_sentiment = mean(sentiment, na.rm = TRUE)) %>%
#   arrange(desc(avg_sentiment))  %>%
#   drop_na(avg_sentiment) %>%
#   hchart("column", hcaes(x = theme, y = avg_sentiment))%>%
#   hc_add_theme(astho_theme) %>%
#   hc_title(text = "Average Sentiment by Theme") %>%
#   hc_yAxis(title = list(text = "AFINN Sentiment Score")) %>%
#   hc_xAxis(title = "",
#            labels = list(enabled = TRUE)) %>%
#   hc_tooltip(pointFormat = "Avg. Sentiment: {point.y:.2f}") %>%
#   hc_colors(colors)
#
# sentiment_chart_e
#
#
# ## Q6: General Impression of Profile -----
#
# q6 <- slidoResults %>%
#   dplyr::filter(`Poll ID` == "F") %>%
#   mutate(scale = case_when(`Poll Option` == 2 ~ "2",
#                            `Poll Option` == 3 ~ "3",
#                            `Poll Option` == 4 ~ "4",
#                            `Poll Option` == 5 ~ "5 (Most Positive)",
#                            TRUE ~ "1 (Most Negative)"),
#          percent = (Count/`Total Votes`)*100)
#
# impression <- q6 %>%
#   hchart("column", hcaes(x = scale, y = percent)) %>%
#   hc_add_theme(astho_theme) %>%
#   hc_xAxis(title = "") %>%
#   hc_yAxis(title = "% of Respondents") %>%
#   hc_tooltip(headerFormat = "",
#              pointFormat = "On a scale of 1-5, {point.y:.2f}% of respondents ranked their impression of the Profile as {point.scale}.")
#
# impression
#
#
# 01. load packages and data -----
library(readxl)
library(magrittr)
library(tidyverse)
library(highcharter)
library(tidytext)
library(stringr)
library(wordcloud)
library(ggplot2)
library(widyr)
library(janitor)  # Added for clean_names()
library(textdata) # Added for sentiment lexicons


afinn <- readRDS("~/Documents/Profile/2025/overview/afinn.rds")
bing <- readRDS("~/Documents/Profile/2025/overview/bing.rds")


# Load data
slidoResults <- read_excel("slidoResults.xlsx",
                           col_types = c("text", "text", "text",
                                         "text", "text", "numeric", "numeric",
                                         "numeric", "text"))

theme_data <- read_excel("themes.xlsx") %>%
  clean_names() %>%  # Standardize column names
  mutate(
    poll_id = tolower(poll_id),  # Ensure consistent case
    across(any_of(c("color", "readability", "usability", "relevance",
                    "feeling", "style", "desire")), as.logical)
  ) %>%
  # Ensure all theme columns exist
  bind_cols(
    !!!set_names(rep(FALSE, 7),
                 .name_repair = ~ c(names(.), c("color", "readability", "usability", "relevance",
                                                "feeling", "style", "desire")[!c("color", "readability", "usability", "relevance",
                                                                                 "feeling", "style", "desire") %in% names(.)])
    ))

    # 02. load themes, etc. ------
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
    dark_main_colors <- c("#325F87","#D86B45", "#A67B05","#287E58", "#15395A") #these are for bubble

    astho_theme <- hc_theme(
      colors = main_colors,
      chart = list(
        backgroundColor = NULL),
      style = list(
        fontFamily = "Jost"),
      title = list(
        style = list(
          color = dark_accent,
          fontFamily = "Jost",
          fontWeight = "bold",
          fontSize = "18px")),
      subtitle = list(
        style = list(
          color = dark_accent,
          fontFamily = "Jost",
          fontSize = "14px")),
      caption = list(
        style = list(
          color = "#666",
          fontFamily = "Jost",
          fontSize = "13px")),
      xAxis = list(
        labels = list(
          style = list(
            fontFamily = "Jost",
            fontSize = "15px",
            fontWeight = "normal",
            color = "#666")),
        title = list(
          style = list(
            color = dark_accent,
            fontFamily = "Jost",
            fontWeight = "500",
            fontSize = "15px"))),
      yAxis = list(
        labels = list(
          style = list(
            fontFamily = "Jost",
            fontSize = "15px",
            fontWeight = "normal",
            color = "#666")),
        title = list(
          style = list(
            color = dark_accent,
            fontFamily = "Jost",
            fontWeight = "500",
            fontSize = "15px"))),
      legend = list(
        itemStyle = list(
          fontFamily = "Jost",
          color = dark_accent,
          fontSize = "17px",
          fontWeight = "normal",
          color = "#666"),
        title = list(
          style = list(
            textDecoration = "underline",
            fontFamily = "Jost",
            fontSize = "16px"))),
      tooltip = list(
        padding = 10,
        borderRadius = 20,
        backgroundColor = "#fff",
        style = list(
          fontFamily = "Jost",
          fontSize = "14px",
          maxWidth = "50%",
          whiteSpace = "normal")),
      useHTML = TRUE,
      itemHoverStyle = list(
        color = light_accent)
    ) #end of code for the astho theme

    # 03. cleaning/analysis -----

    ## Q1: Describe your current mood using one emoji -----

    q1 <- slidoResults %>%
      dplyr::filter(`Poll ID` == "A")

    ## Q2: Profile/Scan data and product familiarity -----

    q2 <- slidoResults %>%
      dplyr::filter(`Poll ID` == "B") %>%
      dplyr::mutate(Percentage = (Count/`Total Votes`)*100)

    familiarity <- q2 %>%
      hchart("pie", hcaes(x = `Poll Option`, y = Percentage)) %>%
      hc_title(text = "Familiarity with Profile/Scan Data & Products <br> (n = 21)") %>%
      hc_chart(crop = FALSE) %>%
      hc_plotOptions(
        pie = list(
          innerSize = "70%",
          allowPointSelect = TRUE,
          cursor = "pointer",
          dataLabels = list(
            enabled = TRUE,
            format = "{point.percentage:.0f}% ",
            distance = "15%",
            style = list(
              fontFamily = "Jost",
              fontSize = "14px"
            ),
            connectorWidth = 3,
            connectorShape = 'fixedOffset'
          ),
          showInLegend = TRUE
        )
      ) %>%
      hc_tooltip(
        useHTML = TRUE,
        headerFormat = "{point.x}",
        pointFormat = "When asked about the Profile and Scan datasets and associated products, {point.percentage:.0f}% of accred. coordinators reported that they were {point.x}.",
        shadow = FALSE,
        borderWidth = 1,
        hideDelay = 1200,
        backgroundColor = "#fff",
        style = list(
          fontFamily = "Jost",
          fontSize = "18px"
        )
      ) %>%
      hc_legend(enabled = TRUE) %>%
      hc_add_theme(astho_theme)

    familiarity

    ## Q3: Feature Appeal Ranking -----

    q3 <- slidoResults %>%
      dplyr::filter(`Poll ID` == "C") %>%
      arrange(desc(Results))

    feature_rank <- hchart(
      q3,
      "bar",
      hcaes(x = `Poll Option`, y = Results)
    ) %>%
      hc_title(text = "Average Feature Ranking (n = 23)") %>%
      hc_tooltip(
        useHTML = TRUE,
        headerFormat = "",
        pointFormat = "<b>Average ranking:</b> {point.y:.2f} <br>",
        style = list(fontSize = "14px")
      ) %>%
      hc_add_theme(astho_theme)

    feature_rank

    ## Q4: Blueprint Wireframe Reactions -----

    q4 <- slidoResults %>%
      dplyr::filter(`Poll ID` == "D") %>%
      arrange(desc(Results))

    # Prepare theme data
    theme_data_d <- theme_data %>%
      filter(poll_id == "d") %>%
      mutate(response_id = row_number())

    # Create long format data
    long_data_d <- theme_data_d %>%
      pivot_longer(
        cols = any_of(c("color", "readability", "usability", "relevance", "feeling", "style", "desire")),
        names_to = "theme",
        values_to = "flag"
      ) %>%
      filter(flag == TRUE) %>%
      select(-flag)

    # Sentiment Analysis
    sentiments_d <- long_data_d %>%
      unnest_tokens(word, phrase) %>%
      inner_join() %>%
      group_by(response_id, theme) %>%
      summarize(sentiment = mean(value), .groups = "drop")

    theme_data_d <- long_data_d %>%
      left_join(sentiments_d, by = c("response_id", "theme"))

    # Theme Frequency Analysis
    word_counts_d <- long_data_d %>%
      unnest_tokens(word, phrase) %>%
      anti_join(stop_words) %>%
      inner_join(parts_of_speech) %>%
      filter(pos == "Adjective") %>%
      count(word, name = "count") %>%
      filter(word != "read") %>%
      mutate(word = case_when(
        word == "overwhelming" ~ "not overwhelming",
        TRUE ~ word
      )) %>%
      arrange(desc(count))

    word_cloud_d <- hchart(word_counts_d, "wordcloud", hcaes(name = word, weight = count)) %>%
      hc_add_theme(astho_theme) %>%
      hc_plotOptions(
        series = list(
          tooltip = list(pointFormat = "<b>{point.word}</b>: {point.count} mentions")
        )
      )

    word_cloud_d

    # Bubble chart
    tidy_data_d <- q4 %>%
      select(`Poll Option`) %>%
      unnest_tokens(word, `Poll Option`) %>%
      anti_join(stop_words) %>%
      filter(!str_detect(word, "\\d+"))

    sentiments_d <- tidy_data_d %>%
      inner_join(bing) %>%
      count(sentiment, word, sort = TRUE)

    blueprint_sentiments <- hchart(
      sentiments_d,
      "packedbubble",
      hcaes(name = word, value = log(n), group = sentiment)
    ) %>%
      hc_add_theme(astho_theme) %>%
      hc_tooltip(pointFormat = "<b>{point.name}") %>%
      hc_plotOptions(
        packedbubble = list(
          maxSize = "125%",
          layoutAlgorithm = list(
            gravitationalConstant = 0.01,
            splitSeries = TRUE
          ),
          dataLabels = list(
            enabled = TRUE,
            format = "{point.name}",
            style = list(
              color = "black",
              textOutline = "none",
              fontWeight = "normal"
            )
          )
        )
      )

    blueprint_sentiments

    # Sentiment by Theme
    sentiment_chart_d <- theme_data_d %>%
      group_by(theme) %>%
      filter(!(theme %in% c("relevance", "desire"))) %>%
      summarize(avg_sentiment = mean(sentiment, na.rm = TRUE)) %>%
      arrange(desc(avg_sentiment)) %>%
      hchart("column", hcaes(x = theme, y = avg_sentiment)) %>%
      hc_add_theme(astho_theme) %>%
      hc_title(text = "Average Sentiment by Theme") %>%
      hc_yAxis(title = list(text = "AFINN Sentiment Score")) %>%
      hc_xAxis(title = "") %>%
      hc_tooltip(pointFormat = "Avg. Sentiment: {point.y:.2f}") %>%
      hc_colors(main_colors)

    sentiment_chart_d

    ## Q5: Profile Dash Landing Page Reactions -----

    q5 <- slidoResults %>%
      dplyr::filter(`Poll ID` == "E")

    # Prepare theme data
    theme_data_e <- theme_data %>%
      filter(poll_id == "e") %>%
      mutate(response_id = row_number())

    # Create long format data
    long_data_e <- theme_data_e %>%
      pivot_longer(
        cols = any_of(c("color", "readability", "usability", "relevance", "feeling", "style", "desire")),
        names_to = "theme",
        values_to = "flag"
      ) %>%
      filter(flag == TRUE) %>%
      select(-flag)

    # Sentiment Analysis
    sentiments_e <- long_data_e %>%
      unnest_tokens(word, phrase) %>%
      inner_join(afinn) %>%
      group_by(response_id, theme) %>%
      summarize(sentiment = mean(value), .groups = "drop")

    theme_data_e <- long_data_e %>%
      left_join(sentiments_e, by = c("response_id", "theme"))

    # Theme Frequency Analysis
    word_counts_e <- long_data_e %>%
      unnest_tokens(word, phrase) %>%
      anti_join(stop_words) %>%
      inner_join(parts_of_speech) %>%
      filter(pos == "Adjective") %>%
      mutate(word = ifelse(word == "easier", "easy", word)) %>%
      count(word, name = "count") %>%
      filter(!(word %in% c("read", "bottom", "related", "half", "prominent"))) %>%
      mutate(word = case_when(
        word == "white" ~ "white space",
        word == "bigger" ~ "bigger font",
        TRUE ~ word
      )) %>%
      arrange(desc(count))

    word_cloud_e <- hchart(word_counts_e, "wordcloud", hcaes(name = word, weight = count)) %>%
      hc_add_theme(astho_theme)

    word_cloud_e

    # Bubble chart
    tidy_data_e <- q5 %>%
      select(`Poll Option`) %>%
      unnest_tokens(word, `Poll Option`) %>%
      anti_join(stop_words) %>%
      filter(!str_detect(word, "\\d+"))

    sentiments_e <- tidy_data_e %>%
      inner_join(bing) %>%
      mutate(
        word = ifelse(word == "overwhelming", "not overwhelming", word),
        sentiment = ifelse(word == "not overwhelming", "positive", sentiment),
        word = ifelse(word == "easier", "easy", word)
      ) %>%
      count(sentiment, word, sort = TRUE)

    dash_sentiments <- hchart(
      sentiments_e,
      "packedbubble",
      hcaes(name = word, value = log(n), group = sentiment)
    ) %>%
      hc_add_theme(astho_theme) %>%
      hc_tooltip(pointFormat = "<b>{point.name}") %>%
      hc_plotOptions(
        packedbubble = list(
          maxSize = "125%",
          layoutAlgorithm = list(
            gravitationalConstant = 0.01,
            splitSeries = TRUE
          ),
          dataLabels = list(
            enabled = TRUE,
            format = "{point.name}",
            style = list(
              color = "black",
              textOutline = "none",
              fontWeight = "normal"
            )
          )
        )
      )

    dash_sentiments

    # Sentiment by Theme
    sentiment_chart_e <- theme_data_e %>%
      group_by(theme) %>%
      filter(!(theme %in% c("relevance", "desire"))) %>%
      summarize(avg_sentiment = mean(sentiment, na.rm = TRUE)) %>%
      arrange(desc(avg_sentiment)) %>%
      hchart("column", hcaes(x = theme, y = avg_sentiment)) %>%
      hc_add_theme(astho_theme) %>%
      hc_title(text = "Average Sentiment by Theme") %>%
      hc_yAxis(title = list(text = "AFINN Sentiment Score")) %>%
      hc_xAxis(title = "") %>%
      hc_tooltip(pointFormat = "Avg. Sentiment: {point.y:.2f}") %>%
      hc_colors(main_colors)

    sentiment_chart_e

    ## Q6: General Impression of Profile -----

    q6 <- slidoResults %>%
      dplyr::filter(`Poll ID` == "F") %>%
      mutate(
        option_num = as.numeric(`Poll Option`),
        scale = case_when(
          option_num == 1 ~ "1 (Most Negative)",
          option_num == 2 ~ "2",
          option_num == 3 ~ "3",
          option_num == 4 ~ "4",
          option_num == 5 ~ "5 (Most Positive)",
          TRUE ~ "Invalid"
        ),
        percent = (Count / `Total Votes`) * 100
      ) %>%
      filter(scale != "Invalid") %>%
      mutate(scale = factor(scale, levels = c("1 (Most Negative)", "2", "3", "4", "5 (Most Positive)")))

    impression <- q6 %>%
      hchart("column", hcaes(x = scale, y = percent)) %>%
      hc_add_theme(astho_theme) %>%
      hc_xAxis(title = "") %>%
      hc_yAxis(title = "% of Respondents") %>%
      hc_tooltip(
        headerFormat = "",
        pointFormat = "On a scale of 1-5, {point.y:.2f}% of respondents ranked their impression as <b>{point.name}</b>."
      )

    impression
