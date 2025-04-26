library(ggplot2)

water <- read.csv("water.csv", stringsAsFactors = T)

head(water, 20)

water$Months <- as.Date(water$Months, format = "%d/%m/%Y")


water_long <- water %>%
  pivot_longer(
    cols = c(ET, Precip, Sws),
    names_to = "Variable",
    values_to = "Value"
  )

scale_factor <- max(water$Precip, na.rm = TRUE) / max(water$Sws, na.rm = TRUE)
ggplot(water, aes(x = Months)) +
  geom_line(aes(y = ET, color = "ET"), size = 1) +
  geom_line(aes(y = Precip, color = "Precip"), size = 1) +
  geom_line(aes(y = Sws * scale_factor, color = "Sws"), size = 1) +
  scale_y_continuous(
    name = "Precip (mm/month) and ET (kg/m^2/month)",
    sec.axis = sec_axis(~ . / scale_factor, name = "Sws (m^3/m^3)")
  ) +
  scale_color_manual(
    values = c("ET" = "magenta", "Precip" = "blue", "Sws" = "orange"),
    name = "Variable"
  ) +
  labs(
    title = "Monthly water cycle",
    x = "Month"
  ) +
  theme_minimal() +
  theme(
    legend.position = c(0.05, 0.95),  # Top-left corner
    legend.justification = c(0, 1)    # Anchor to top-left
  )
