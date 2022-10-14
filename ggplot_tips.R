
# Set scales to percent
scale_y_continuous(labels = scales::percent)

# Geom text for columns (alternate position fill/dodge)
geom_text(aes(label = ifelse(pct > 0.05, paste(round(pct*100)), '')), 
            position = position_fill(vjust = 0.5, reverse = T))
            
            
            
# Misc. facet wrap tools
facet_wrap(~ trad, ncol = 1, strip.position = 'left') +
  theme(strip.text.y.left = element_text(angle = 0))
  
  




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

