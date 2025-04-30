library(ncdf4)   
library(raster) 
library(sf)      
library(ggplot2)
library(lubridate)
library(tidyr)
library(dplyr)

# annual data barplot
# Open the NetCDF file
rf2 <- "ridgefield_2015_2024_L6_Summary.nc"
rf_data2 <- nc_open(rf2)

annual_gpp <- ncvar_get(rf_data2, "Annual/GPP_SOLO")  
annual_et <- ncvar_get(rf_data2, "Annual/ET")

time3 <- ncvar_get(rf_data2, "Annual/time")
time_units3 <- ncatt_get(rf_data2, "Annual/time", "units")$value
origin3 <- as.Date(strsplit(time_units3, "since ")[[1]][2])
dates3 <- origin3 + time3

df3 <- data.frame(date = dates3, gpp = annual_gpp)
df3$annual_et <- annual_et

df_long <- df3 %>%
  pivot_longer(cols = c(gpp, annual_et),
               names_to = "variable",
               values_to = "measurement") %>%
  mutate(variable = factor(variable, levels = c("gpp", "annual_et")))

ggplot(df_long, aes(x = date, y = measurement, fill = variable)) +
  geom_col(position = position_dodge(width = 200), width = 200) +
  scale_x_date(limits = as.Date(c("2015-08-01", "2024-05-01")),
               date_breaks = "1 year",
               date_labels = "%Y") +
  scale_y_continuous(limits = c(0, 700)) +
  scale_fill_manual(
    values = c("gpp" = "#EFC000FF", "annual_et" = "#0073C2FF"),
    labels = c("Annual GPP", "Annual ET")
  ) +
  labs(title = "Annual GPP and ET",
       x = NULL, y = "GPP (gC/m^2/year), ET (kg/m^2/year)", fill = "Variable") +
  theme_minimal() +
  theme(
    legend.position = c(0.98, 0.98),        
    legend.justification = c("right", "top"), 
    legend.background = element_rect(fill = "white", color = "gray80")
  )
