install.packages("palmerpenguins")
library("palmerpenguins")
library("tidyverse")

penguins %>% 
  arrange(-bill_length_mm)

penguins2 <- penguins %>% 
  arrange(-bill_length_mm)
View(penguins2)

penguins %>% 
  group_by(island) %>% 
  drop_na() %>% 
  summarise(mean_bill_length_mm = mean(bill_length_mm))

penguins %>% 
  group_by(island) %>% 
  count(island) %>% 
  drop_na()

summarise("penguins")

penguins %>% 
  group_by(island) %>% 
  drop_na() %>% 
  summarise(max_bill_length_mm = max(bill_length_mm))

penguins %>% 
  group_by(island, species) %>% 
  drop_na() %>% 
  summarise(max_length = max(bill_length_mm), mean_length = mean(bill_length_mm))

penguins %>% 
  filter(species == "Adelie")

penguins %>% 
  filter(species == "Adelie") %>% 
  summarise(mean_length = mean(bill_length_mm))

id <- c(1:10)

name <- c("John Mendes", "Rob Stewart", "Rachel Abrahamson", "Christy Hickman", "Johnson Harper", "Candace Miller", "Carlson Landy", "Pansy Jordan", "Darius Berry", "Claudia Garcia")

job_title <- c("Professional", "Programmer", "Management", "Clerical", "Developer", "Programmer", "Management", "Clerical", "Developer", "Programmer")

employee <- data.frame(id, name, job_title)

print(employee)

library(tidyr)
separate(employee, name, into = c("First_name", "Last_name"), sep = " ")

install.packages("palmerpenguins")
library("palmerpenguins")
library("tidyverse")
View(penguins)

head(penguins)

kg_measure <- penguins %>% 
  mutate(body_mass_kg=body_mass_g/1000)

head(kg_measure)

new_penguins <- unite(penguins,"regional_species", island, species, sep = "_")
  
library(dplyr)
View(penguins)
penguins %>% 
  select(island) %>% 
  rename_with(island, toupper)

install.packages("Tmisc")
library(Tmisc)
data("quartet")
View(quartet) # the table is classified into 4 datasets
# we'll get the mean, S.D., and correlation for each of the dataset

library(dplyr)
quartet %>% 
  group_by(set) %>% 
  summarise(mean_x = mean(x), mean_y = mean(y))

quartet %>% 
  group_by(set) %>% 
  summarise(mean(x), sd(x), mean(y), sd(y), cor(x,y))

library(tidyverse)
ggplot(quartet, aes(x,y)) + geom_point() + geom_smooth(method = lm, se = FALSE) + facet_wrap(-set)

install.packages("datasauRus")
library(datasauRus)
library(tidyverse)
ggplot(datasaurus_dozen, aes(x=x, y=y, color=dataset)) 
+ geom_point() + theme_void() + theme(legend.position = "none") + facet_wrap(-dataset, ncol = 3)

install.packages("SimDesign")
library(SimDesign)
actual_temp <- c(68.3, 70, 72.4, 71, 67, 70)
predicted_temp <- c(67.9, 69, 71.5, 70, 67, 69)
bias(actual_temp, predicted_temp)

actual_sales <- c(150, 203, 137, 247, 116, 287)
predicted_sales <- c(200, 300, 150, 250, 150, 300)
bias(actual_sales, predicted_sales)

library(ggplot2)
library("palmerpenguins")
data("penguins")
View(penguins)

ggplot(data=penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = body_mass_g, y = flipper_length_mm))
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species, shape = species))
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, alpha = species))
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g), color = "red")

ggplot(data = penguins) + 
  geom_point(mapping = aes(x = body_mass_g, y = flipper_length_mm, color = species)) + facet_wrap(~species)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut)) +
  facet_wrap(~cut)

ggplot(data = penguins) + 
  geom_point(mapping = aes(x = body_mass_g, y = flipper_length_mm, color = species)) + 
  facet_grid(sex~species)

p <- ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species))
p + labs(title = "Palmer Penguins: Flipper Length vs. Body Mass", subtitle = "Sample of Three Species", caption = "Data collected by Dr. Kristen Gorman") +
  annotate("text", x = 220, y = 3500, label = "The gentoos are the biggest!", fontface = "bold", color = "dark red", size = 6, angle = 0)

ggsave("Three Palmer Penguins Species.pdf")
