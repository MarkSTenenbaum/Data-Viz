
# Set scales to percent
scale_y_continuous(labels = scales::percent)

# Left align labels
+ theme(axis.text.y = element_text(hjust = 0))

# Geom text for columns (alternate position fill/dodge)
geom_text(aes(label = ifelse(pct > 0.05, paste0(round(pct*100), '%'), '')), 
            position = position_fill(vjust = 0.5))

# Centering x-axis text label in combined plots through patchwork
p1 + p2 + plot_layout(guides = 'collect') + 
  plot_annotation(caption = 'Unequal Criminal Justice for Blacks and Latinos', 
                  theme = theme(plot.caption = element_text(hjust = 0.35, size = 12, vjust = 6))) 

# Centering y-axis text label in combined plots through patchwork
pp <- p1 + p2 + plot_layout(ncol = 1)  

wrap_elements(pp)+
  labs(tag = 'Evangelical Religiosity Index') +
  theme(
    plot.tag = element_text(size = 12, angle = 90),
    plot.tag.position = "left",
  )
            
# Misc. facet wrap tools
facet_wrap(~ trad, ncol = 1, strip.position = 'left') +
  theme(strip.text.y.left = element_text(angle = 0),
        panel.spacing = unit(2, "lines"))             # adds more space between plots
  
# See available themes
ggthemes()


# Using existing pallettes 
scale_fill_brewer(palette = 'Accent')

# Setting manual colors
scale_fill_manual(values = c('blue', 'gray60', 'firebrick'))


# Grouping plots together (example)
library(patchwork)
all <- (age.plot + educ.plot) / (inc.plot + ideo.plot) / (att.plot + reg.plot)
all


# Interact plot example (for 2 or 3 way interactions)
interact_plot(party2, pred= pew_churatd, modx = Race2, mod2 = trad,
              int.width = .95, interval = TRUE,
              mod2.labels = c('Something else', 'Catholic', 'Evangelical Protestant',
                              'Non-Evangelical Protestants', 'Unaffiliated'),
              main.title = 'Separately by Tradition',
              x.label = 'Frequency of Religious Service Attendance',
              y.label = '')
              
# Plot regression coefficients
issue.plot.other <- jtools::plot_summs(mod_abort, mod_gs, mod_imm, mod_pol, mod_gun, 
                                      mod_env, mod_health, mod_help, 
                                      coefs = c('att'), # subset for only some coefficients
                                      colors = c('red', 'blue', 'green', 'purple', 'orange', 
                                                 'yellow', 'black', 'gray'),
                                      model.names = c('Abortion', 'Gender/Sexuality', 'Immigration',
                                                      'Police', 'Guns', 'Environment', 'Healthcare', 
                                                      'Help Poor'))
                                                      
# Plotting with SJ plot (when interact plot is funky)...example
library(cowplot)
library(sjPlot)

# liberal ideology with side-by-side plots of LGB and transgender - (predicted probabilities, 2016 + 2020)

pred1_lgb_16 <- plot_model(mod1_lib_lgb_16, type = 'pred', terms = c('trad', 'LGB[0,1]')) 
pred1_lgb_16 <- pred1_lgb_16 + theme_bw() + labs(y = 'Liberal', x = '', title = 'LGB 2016') + ylim(0.4, 0.8)


# How to manually override aesthetics to adjust your legend. (Here I'm adjusting colors of my linetype legend, but it could be a fill/color/group legend, etc.)
guides(linetype = guide_legend(override.aes = list(color = c('black', 'gray50', 'gray70', 'gray85'))))

# How to remove specific legend if having double-legend issue (e.g., remove fill/color/group/linetype)
giudes(color = 'none') 

# reverse order of legend
guides(fill = guide_legend(reverse = TRUE))

# How to manually arrange plots 
layout <- "
AABBCC
#DDEE#
"
plot <- sjplot + displot +chooseplot + bornplot + cultplot + plot_layout(guides = "collect", design = layout)
ggsave('test2.png', height = 15, width = 25)

# How to take separate legends from diff plots and replace it w/ one legend, centered on the right
plot_layout(guides = "collect") # see example above

# space between items on legend
legend.key.size = unit(3, 'lines')


