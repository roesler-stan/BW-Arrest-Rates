source_offenders = ColumnDataSource(percent_black[percent_black['type'] == 'Offenders'])
source_arrested = ColumnDataSource(percent_black[percent_black['type'] == 'Arrested'])
source_arrested_sameday = ColumnDataSource(percent_black[percent_black['type'] == 'Arrested Same Day'])
source_arrested_otherday = ColumnDataSource(percent_black[percent_black['type'] == 'Arrested Other Day'])
offender_labels = LabelSet(x="offense", y="percent_black", text="percent_black", y_offset=6, x_offset=-18,
                  text_font_size="5pt", text_color="#555555", source=source_offenders, text_align='center')
arrested_labels = LabelSet(x="offense", y="percent_black", text="percent_black", y_offset=6, x_offset=-6,
                  text_font_size="5pt", text_color="#555555", source=source_arrested, text_align='center')
arrested_sameday_labels = LabelSet(x="offense", y="percent_black", text="percent_black", y_offset=6, x_offset=6,
                  text_font_size="5pt", text_color="#555555", source=source_arrested_sameday, text_align='center')
arrested_otherday_labels = LabelSet(x="offense", y="percent_black", text="percent_black", y_offset=6, x_offset=18,
                  text_font_size="5pt", text_color="#555555", source=source_arrested_otherday, text_align='center')
p1.add_layout(offender_labels)
p1.add_layout(arrested_labels)
p1.add_layout(arrested_sameday_labels)
p1.add_layout(arrested_otherday_labels)