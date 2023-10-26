---
title: 'NewIndexUpLoad'
author: "Brooke Mills"
date: "2023-09-07"
output: pdf_document
---

```{r, warning=FALSE}
library(tidyverse)
library(sf)
library(ggspatial)
library(spData)
library(shapefiles)
library(tinytex)
library(latexpdf)

data <- read_sf("cejst.shp")
data

ga <- data %>%
  filter(SF == "Georgia") # filtering out the unnecessary rows
view(ga)

#view(data1) #my attempt to view the shx file, whenever I run this it crashes R
```



```{r}
#adding a new row into R
ga2 <- ga %>%
  mutate(dm_nw = 1-DM_W)
ga2 

#trying out visualization
ggplot() +
  geom_sf(data = ga2, aes(fill = dm_nw)) + scale_fill_gradient(low = "white", high = "blue") 
```


```{r}
# creating the new columns up the 1/0 scores from each bucket and totaling
ga3 <- ga %>%
  mutate(CCN = ((EAL_ET) + (EBL_ET) + (EPL_ET) + (FLD_ET) + (WFR_ET))/5) %>%
  mutate(EEN = ((EB_ET)+ (PM25_ET))/2) %>%
  mutate(HHN = ((A_ET) +(DB_ET) + (HD_ET) + (LLE_ET))/4) %>%
  mutate(HSN = ((HB_ET) + (KP_ET) + (LPP_ET))/3) %>%
  mutate(LPN = ((AML_ET) + (FUDS_ET) + (TSDF_ET) + (NPL_ET) + (RMP_ET))/5) %>%
  mutate(TTN = ((DS_ET) + (TD_ET) + (TP_ET))/3) %>%
  mutate(WWN = ((UST_ET) + (WD_ET))/2) %>%
  mutate(WDN = ((LISO_ET) + (IA_LMI_ET) + (IA_POV_ET) + (IA_UN_ET) + (IALHE))/5) %>%
  mutate(Total = (CCN + EEN + HHN + HSN + LPN + TTN + WWN + WDN))
ga3
view(ga3) #viewing new dataset

st_write(ga3, "newnewshp7.shp") #exporting the new dataset as a .shp file
st_write(ga3, "typls7.shx", driver = 'ESRI Shapefile') # gives shp, shx, and dbf files, hopefully functional!


```


```{r}
newga4 <- ga3 %>%
  st_drop_geometry()

listnew5 <- newga4 %>%
  select(GEOID10, CF, Total) %>%
  st_drop_geometry() %>%
  arrange(desc(Total))
listnew5

st_write(listnew5, "4orderedburdenedlist.csv")
```