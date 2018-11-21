##########################################
## Service Type By Occasions of Service ##
##########################################

datatab.2 = aggregate(Occasions ~ svc_type, data=data, sum, na.rm=TRUE)
names(datatab.2)
colnames(datatab.2)[1] = "Service_Type"

ggplot(data = datatab.2, aes(x = Service_Type, y = as.numeric(Occasions), fill = Service_Type)) +
	geom_bar(stat = "identity",width = 1) +
	geom_text(aes(y = Occasions, label = Occasions), size=4, show.legend = FALSE) +
	geom_label(aes(y = Occasions, label = Occasions), alpha = 0, show.legend = FALSE) +
	coord_polar(theta = "x") +
	guides(fill=guide_legend(title="Service Type")) +
	theme(legend.box.background = element_rect(colour="grey50"), 
		legend.box.margin = margin(6, 6, 6, 6),
		legend.key = element_rect(fill = "white", colour = "black"), 
		legend.title = element_text(face = "bold"),
		plot.title = element_text(face="bold", size = 18)) +
	labs(title = "Occasions of Service by Service Type",
		subtitle = "Silver Chain Group FINE Report June 2018", 
		y = "Occasions of Service",
		x = "Service Type") +
	theme(axis.text=element_text(size=12,face="bold"))
