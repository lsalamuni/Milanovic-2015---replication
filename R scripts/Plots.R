#---
#title: "Plots"
#author: "Lucas Salamuni - 7429674"
#date: "2025-08-13"
#output: pdf_document
#---

# Packages


packages <- c("dplyr", "knitr", "tinytex", "readxl", "tidyr", "fastDummies",
              "sandwich", "lmtest", "estimatr", "purrr", "tibble", "writexl",
              "ggplot2", "scales", "ggrepel", "sessioninfo")

if(sum(as.numeric(!packages %in% installed.packages())) != 0){ 
  instalador <- packages[!packages %in% installed.packages()] 
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(packages, require, character = T)
} else {
  sapply(packages, require, character = T)
}





## Session info


session_info()





# **Part 1. Pure Replication** 



## 1.1. Retrieve Part 1's data


# I. Load data from "Final Project.Rmd"'s first part
load("Datasets/replication_results_part1.RData")




## 1.2. Figure 1's replication


df_fig1.1 <- df %>%
  filter(contcod %in% c("BRA", "CHN", "DEU", "IND", "RUS"))

percentile_points <- df_fig1.1 %>%
  filter(group %in% c(1, 25, 50, 75, 100))

deu_min_income <- df %>%
  filter(contcod == "DEU" & group == 1) %>%
  select(inc) %>%
  as.numeric()

economist_colors <- c("BRA" = "#009B3A",
                      "CHN" = "#d5001c",
                      "DEU" = "#ed8b00",
                      "IND" = "#FFD700",
                      "RUS" = "#006ba6")

plot_1.1 <- ggplot(data = df_fig1.1,
                   aes(y = inc, x = group,
                       group = contcod,
                       colour = as.factor(contcod))) +
  geom_line(size = 0.8) +
  geom_point(data = percentile_points,
             size = 3,
             alpha = 1) +
  geom_hline(yintercept = deu_min_income,
             linetype = "dashed",
             color = "#5c5c5c",
             size = 0.6,
             alpha = 0.8) +
  scale_y_log10(labels = scales::label_comma(),
                breaks = c(100, 1000, 10000, 50000),
                limits = c(100, NA)) +
  scale_x_continuous(breaks = c(1, 20, 40, 60, 80, 100),
                     limits = c(1, 100)) +
  scale_colour_manual(values = economist_colors) +
  labs(title = "Income distribution across countries",
       subtitle = "Income by country percentile, 2008",
       y = "Income in PPP dollars",
       x = "Country percentile",
       colour = NULL,
       caption = "Source: WYD, Branko (2015) \nNote: Points represent the 1st, 25th, 50th, 75th and 100th percentiles") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0, lineheight = 1.2),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom",
        legend.text = element_text(size = 10),
        legend.key.height = unit(0.5, "cm"),
        legend.key.width = unit(1.5, "cm"),
        legend.margin = margin(t = 10),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20)) +
  annotate("text", 
           x = 70, 
           y = deu_min_income * 1.3,
           label = "Germany's poorest percentile",
           size = 3.5,
           color = "#5c5c5c",
           fontface = "italic")

print(plot_1.1)

ggsave(filename = "Plots/plot_1.1.png",
       plot = plot_1.1,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white") 






# **Part 2. Pure Replication** 

## 2.1. Continent *facet_wrap* comparison


df_fig2.1 <- read_excel(path = "Datasets/WYD_reg.xlsx")

percentile_points <- df_fig2.1 %>%
  filter(group %in% c(1, 25, 50, 75, 100))

economist_colors <- c("Africa" = "#009B3A",
                      "Asia" = "#D5001C",
                      "Central America" = "#ED8B00",
                      "Europe" = "#FFD700",
                      "North America" = "#006BA6",
                      "Oceania" = "#7F3C8D",
                      "South America" = "#00A6A6")

plot_2.1 <- ggplot(data = df_fig2.1,
                   aes(y = inc, x = group,
                       group = contcod,
                       colour = as.factor(reg))) +
  geom_line(size = 0.8) +
  geom_point(data = percentile_points,
             size = 3,
             alpha = 1) +
  facet_wrap(facets = "reg") +
  scale_y_log10(labels = scales::label_comma(),
                breaks = c(100, 1000, 10000, 50000),
                limits = c(100, NA)) +
  scale_x_continuous(breaks = c(1, 20, 40, 60, 80, 100),
                     limits = c(1, 100)) +
  scale_colour_manual(values = economist_colors) +
  labs(title = "Income distribution across countries",
       subtitle = "Income by country percentile, 2008",
       y = "Income in PPP dollars",
       x = "Country percentile",
       colour = NULL,
       caption = "Source: WYD, Branko (2015) \nNote: Points represent the 1st, 25th, 50th, 75th and 100th percentiles") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0, lineheight = 1.2),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom",
        legend.text = element_text(size = 10),
        legend.key.height = unit(0.5, "cm"),
        legend.key.width = unit(1.5, "cm"),
        legend.margin = margin(t = 10),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20))

print(plot_2.1) # graph looks too "polluted" and barely offers any insights (probably will not be using it)




# 2.2. Cross-continent comparison I (income, population, gdp, gini)


df_fig2.2 <- read_excel(path = "Datasets/WYD_cont.xlsx")

df_fig2.2 <- df_fig2.2 %>%
  group_by(reg) %>%
  summarise(avg_inc = mean(inc),
            pop = mean(pop),
            gdpppp = mean(gdpppp),
            gini = mean(gini))

head(df_fig2.2)

economist_colors <- c("Africa" = "#d5001c",
                      "Asia" = "#d5001c",
                      "Central America" = "#d5001c",
                      "Europe" = "#d5001c",
                      "North America" = "#d5001c",
                      "Oceania" = "#d5001c",
                      "South America" = "#d5001c")


# Plot 1
plot_2.2.inc <- ggplot(data = df_fig2.2, 
                   aes(x = avg_inc,
                       y = reg,
                       fill = as.factor(reg))) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = economist_colors) +
  labs(title = "Average per capita income by continent",
       subtitle = "2008 data",
       y = NULL,
       x = "USD",
       fill = "Continent",
       caption = "Source: WYD, Branko (2015)") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.text.x = element_text(size = 11, hjust = 1, vjust = 1, margin = margin(t = 5)),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        axis.ticks.x = element_blank(),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20),
        legend.position = "none")

print(plot_2.2.inc)

ggsave(filename = "Plots/plot_2.2.inc.png",
       plot = plot_2.2.inc,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white")


# Plot 2
plot_2.2.gdp <- ggplot(data = df_fig2.2, 
                   aes(x = gdpppp,
                       y = reg,
                       fill = as.factor(reg))) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = economist_colors) +
  labs(title = "Average GDP per capita by continent",
       subtitle = "2008 data",
       y = NULL,
       x = "USD",
       fill = "Continent",
       caption = "Source: WYD, Branko (2015)") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.text.x = element_text(size = 11, hjust = 1, vjust = 1, margin = margin(t = 5)),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        axis.ticks.x = element_blank(),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20),
        legend.position = "none")

print(plot_2.2.gdp)

ggsave(filename = "Plots/plot_2.2.gdp.png",
       plot = plot_2.2.gdp,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white")


# Plot 3
plot_2.2.gini <- ggplot(data = df_fig2.2, 
                   aes(x = gini,
                       y = reg,
                       fill = as.factor(reg))) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = economist_colors) +
  labs(title = "Average Gini by continent",
       subtitle = "2008 data",
       y = NULL,
       x = "Gini index",
       fill = "Continent",
       caption = "Source: WYD, Branko (2015)") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.text.x = element_text(size = 11, hjust = 1, vjust = 1, margin = margin(t = 5)),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        axis.ticks.x = element_blank(),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20),
        legend.position = "none")

print(plot_2.2.gini)

ggsave(filename = "Plots/plot_2.2.gini.png",
       plot = plot_2.2.gini,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white")




## 2.3. Cross-continent comparison II (income, population, gdp, gini)


df_fig2.3 <- read_excel(path = "Datasets/WYD_reg.xlsx")

df_fig2.3 <- df_fig2.3 %>%
  group_by(contcod, cont, reg) %>%
  summarise(inc = mean(inc),
            pop = sum(pop),
            gdpppp = mean(gdpppp, na.rm = TRUE),
            gini = mean(gini, na.rm = TRUE)) %>%
  arrange(reg)

economist_colors <- c("Africa" = "#d5001c",
                      "Asia" = "#d5001c",
                      "Central America" = "#d5001c",
                      "Europe" = "#d5001c",
                      "North America" = "#d5001c",
                      "Oceania" = "#d5001c",
                      "South America" = "#d5001c")

top_cont <- c("USA", "PAR", "JPN", "GBR", "PRT", "ITA", "ESP", "DEU", "ARG", "CAN", "BRA")

df_top <- df_fig2.3 %>%
  filter(contcod %in% top_cont)

bra_income <- df_top %>% 
  filter(contcod == "BRA") %>% 
  pull(inc)

bra_gini <- df_top %>% 
  filter(contcod == "BRA") %>% 
  pull(gini)

# Plot 1
plot_2.3.inc <- ggplot(df_fig2.3, aes(x = reg,
                                      y = inc,
                                      fill = as.factor(reg))) +
  geom_boxplot(alpha = 0.35) +
  geom_point(alpha = 0.2, size = 1) +
  geom_hline(yintercept = bra_income, 
             linetype = "dashed", 
             color = "darkgray", 
             size = 0.8) +
  geom_point(data = df_top,
             aes(x = reg, y = inc),
             color = "red",
             size = 1.2) +
  geom_text(data = df_top,
            aes(x = reg, y = inc, label = contcod),
            color = "black",
            size = 2.2,
            fontface = "bold",
            hjust = -0.3,
            nudge_x = 0.15) +
  coord_flip() +
  scale_fill_manual(values = economist_colors) +
  labs(title = "Per capita income by continent",
       subtitle = "2008 data",
       y = "USD",
       x = NULL,
       fill = "Continent",
       caption = "Source: WYD, Branko (2015)") + 
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.text.x = element_text(size = 11, hjust = 1, vjust = 1, margin = margin(t = 5)),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        axis.ticks.x = element_blank(),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20),
        legend.position = "none")

print(plot_2.3.inc)

ggsave(filename = "Plots/plot_2.3.inc.png",
       plot = plot_2.3.inc,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white")

# Plot 2
df_top_labels <- df_top %>%
  mutate(nudge_y_custom = case_when(contcod == "USA" ~ 0.01,
                                    contcod == "PRT" ~ 0.01,
                                    contcod == "ESP" ~ -0.01,
                                    contcod == "ITA" ~ 0.01,
                                    contcod == "DEU" ~ 0.005,
                                    contcod == "GBR" ~ 0.01,
                                    contcod == "BRA" ~ 0.01,
                                    TRUE ~ 0))

plot_2.3.gini <- ggplot(df_fig2.3, aes(x = reg, 
                                       y = gini,
                                       fill = as.factor(reg))) +
  geom_hline(yintercept = bra_gini, 
             linetype = "dashed", 
             color = "darkgray", 
             size = 0.8) +
  geom_boxplot(alpha = 0.35) +
  geom_point(alpha = 0.2, size = 1) +
  geom_point(data = df_top,
             aes(x = reg, y = gini),
             color = "red",
             size = 1.2) +
  geom_text(data = df_top_labels,
            aes(x = reg, 
                y = gini + nudge_y_custom, 
                label = contcod),
            color = "black",
            size = 2.2,
            fontface = "bold",
            nudge_x = 0.2) +
  coord_flip() +
  scale_fill_manual(values = economist_colors) +
  labs(title = "GDP per capita by continent",
       subtitle = "2008 data",
       y = "USD",
       x = NULL,
       fill = "Continent",
       caption = "Source: WYD, Branko (2015)") + 
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.text.x = element_text(size = 11, hjust = 1, vjust = 1, margin = margin(t = 5)),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        axis.ticks.x = element_blank(),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20),
        legend.position = "none")

print(plot_2.3.gini)

ggsave(filename = "Plots/plot_2.3.gdp.png",
       plot = plot_2.3.gini,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white")




## 2.4. Income distribution across continents


df_fig2.4 <- read_excel(path = "Datasets/WYD_cont.xlsx")

percentile_points <- df_fig2.4 %>%
  filter(group %in% c(1, 25, 50, 75, 100))

economist_colors <- c("Africa" = "#009B3A",
                      "Asia" = "#D5001C",
                      "Central America" = "#ED8B00",
                      "Europe" = "#FFD700",
                      "North America" = "#006BA6",
                      "Oceania" = "#7F3C8D",
                      "South America" = "#00A6A6")

plot_2.4 <- ggplot(data = df_fig2.4,
                   aes(y = inc, x = group,
                       group = reg,
                       colour = as.factor(reg))) +
  geom_line(size = 0.8) +
  geom_point(data = percentile_points,
             size = 3,
             alpha = 1) +
  scale_y_log10(labels = scales::label_comma(),
                breaks = c(100, 1000, 10000, 50000),
                limits = c(100, NA)) +
  scale_x_continuous(breaks = c(1, 20, 40, 60, 80, 100),
                     limits = c(1, 100)) +
  scale_colour_manual(values = economist_colors) +
  labs(title = "Income distribution across continents",
       subtitle = "Income by continent percentile, 2008",
       y = "Income in PPP dollars",
       x = "Continent percentile",
       colour = NULL,
       caption = "Source: WYD, Branko (2015) \nNote: Points represent the 1st, 25th, 50th, 75th and 100th percentiles") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0, lineheight = 1.2),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom",
        legend.text = element_text(size = 10),
        legend.key.height = unit(0.5, "cm"),
        legend.key.width = unit(1.5, "cm"),
        legend.margin = margin(t = 10),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20))

print(plot_2.4)

ggsave(filename = "Plots/plot_2.4.inc.png",
       plot = plot_2.4,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white")






# **Part 3. A closer look at Brazil** 

## 3.1. Top 10 destinations for Brazilian migrants (2008)


bra_pop <- df %>%
  filter(contcod == "BRA") %>%
  group_by(contcod) %>%
  summarise(pop = sum(pop)*1000000) %>%
  select(pop) %>%
  as.numeric()

mig <- tibble("contcod" = c("USA", "PRT", "GBR", "DEU", "ESP", "ITA", "CAN", "JPN", "ARG", "PAR"),
              "reg" = c("North America", "Europe", "Europe", "Europe", "Europe", "Europe", "North America", "Asia", "South America", "South America"),
              "qtd" = c(1240000, 147500, 150000, 46200, 110000, 132000, 20650, 310000, 38500, 487500))

print(mig)

region_colors <-  c("Africa" = "#4B0000",
                    "Asia" = "#FF6B6B",        
                    "Central America" = "#B22222",
                    "Europe" = "#800020",
                    "North America" = "#FF0000",
                    "Oceania" = "#FF6B6B",
                    "South America" = "#FFB3BA")  

plot_3.1 <- ggplot(data = mig, 
                   aes(x = reorder(contcod, -qtd),
                       y = qtd,
                       fill = as.factor(reg))) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = region_colors) + 
  scale_y_continuous(labels = scales::label_comma(),
                     expand = expansion(mult = c(0, 0.05))) +
  labs(title = "Brazilian expats in 2008",
       subtitle = "Population living in Brazil at the time: 1.919 mi",
       y = "Population",
       x = NULL,
       fill = "Continent",
       caption = "Source: Brazilian Ministry of Foreign Affairs") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.text.x = element_text(size = 11, margin = margin(t = 5)),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        axis.ticks.x = element_blank(),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20),
        legend.position = "right",
        legend.title = element_text(size = 10, color = "#2b2b2b"),
        legend.text = element_text(size = 9, color = "#5c5c5c"))

print(plot_3.1)

ggsave(filename = "Plots/plot_3.1.png",
       plot = plot_3.1,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white") 




## 3.2. Income comparison: Brazil vs. top 10 expats' destinations


df_fig3.2 <- df %>%
  filter(contcod %in% c("BRA", "USA", "PRT", "GBR", "DEU", "ESP", "ITA", "CAN", "JPN", "ARG", "PAR")) %>%
  mutate(bra = factor(case_when(contcod == "BRA" ~ "Brazil",
                                contcod %in% c("ARG", "PAR") ~ "SA countries",  
                                TRUE ~ "Other countries"),
                      levels = c("Other countries", "SA countries", "Brazil")))

percentile_points <- df_fig3.2 %>%
  filter(group %in% c(1, 25, 50, 75, 100))

bra_mid_income <- df %>%
  filter(contcod == "BRA" & group == 50) %>%
  pull(inc)

economist_colors <- c("Brazil" = "#d5001c",
                      "SA countries" = "darkgrey",
                      "Other countries" = "lightgrey")

plot_3.2 <- ggplot(data = df_fig3.2,
                   aes(y = inc, x = group,
                       group = contcod,
                       colour = bra)) +
  geom_line(data = filter(df_fig3.2, bra == "Other countries"), 
            size = 0.8) +
  geom_point(data = filter(percentile_points, bra == "Other countries"),
             size = 3,
             alpha = 1) +
  geom_line(data = filter(df_fig3.2, bra == "SA countries"), 
            size = 0.8) +
  geom_point(data = filter(percentile_points, bra == "SA countries"),
             size = 3,
             alpha = 1) +
  geom_line(data = filter(df_fig3.2, bra == "Brazil"), 
            size = 0.8) +
  geom_point(data = filter(percentile_points, bra == "Brazil"),
             size = 3,
             alpha = 1) +
  geom_hline(yintercept = bra_mid_income,
             linetype = "dashed",
             color = "#5c5c5c",
             size = 0.6,
             alpha = 0.8) +
  scale_y_log10(labels = scales::label_comma(),
                breaks = c(100, 1000, 10000, 50000),
                limits = c(100, NA)) +
  scale_x_continuous(breaks = c(1, 20, 40, 60, 80, 100),
                     limits = c(1, 100)) +
  scale_colour_manual(values = economist_colors) +
  labs(title = "Income distribution: Brazil vs. top 10 expats' destinations",
       subtitle = "Income by country percentile, 2008",
       y = "Income in PPP dollars",
       x = "Country percentile",
       colour = NULL,
       caption = "Source: WYD, Branko (2015)\nNote: Points represent the 1st, 25th, 50th, 75th and 100th percentiles") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", margin = margin(b = 5)),
        plot.subtitle = element_text(size = 12, color = "#5c5c5c", margin = margin(b = 10)),
        plot.caption = element_text(size = 9, color = "#5c5c5c", hjust = 0, lineheight = 1.2),
        axis.line = element_line(color = "#5c5c5c", size = 0.8),
        axis.text = element_text(size = 10, color = "#5c5c5c"),
        axis.title = element_text(size = 11, color = "#2b2b2b", face = "plain"),
        axis.ticks = element_line(color = "#5c5c5c", size = 0.5),
        panel.grid.major.y = element_line(color = "#e5e5e5", size = 0.5),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom",
        legend.text = element_text(size = 10),
        legend.key.height = unit(0.5, "cm"),
        legend.key.width = unit(1.5, "cm"),
        legend.margin = margin(t = 10),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA),
        plot.margin = margin(20, 20, 20, 20)) +
  annotate("text", 
           x = 92.5, 
           y = bra_mid_income * 1.4,
           label = "Brazil's 50th percentile",
           size = 3.5,
           color = "#5c5c5c",
           fontface = "italic")

print(plot_3.2)

ggsave(filename = "Plots/plot_3.2.png",
       plot = plot_3.2,
       width = 10,
       height = 6,
       dpi = 300,
       bg = "white") 

