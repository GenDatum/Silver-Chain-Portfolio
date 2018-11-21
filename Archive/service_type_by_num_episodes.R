#########################
### Service Type Freq ###
#########################

datatab = data.frame(table(data$svc_type))
colnames(datatab)[1] = "Service_Type"


ggplot(data = datatab, aes(x = Service_Type, y = as.numeric(Freq), fill = Service_Type)) +
	geom_bar(stat = "identity",width = 1) +
	geom_text(aes(y = Freq, label = Freq), size=4, show.legend = FALSE) +
	geom_label(aes(y = Freq, label = Freq), alpha = 0, show.legend = FALSE) +
	coord_polar(theta = "x") +
	guides(fill=guide_legend(title="Service Type")) +
	theme(legend.box.background = element_rect(colour="grey50"), 
		legend.box.margin = margin(6, 6, 6, 6),
		legend.key = element_rect(fill = "white", colour = "black"), 
		legend.title = element_text(face = "bold"),
		plot.title = element_text(face="bold", size = 18)) +
	labs(title = "Service Episodes by Service Type",
		subtitle = "Silver Chain Group FINE Report June 2018", 
		y = "Frequency",
		x = "Service Type") +
	theme(axis.text=element_text(size=12,face="bold"))


