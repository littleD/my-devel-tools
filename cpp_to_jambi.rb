#!/usr/bin/env ruby

swap = {
"\\<ui version=\"4\\.0\"\\>" => "<ui version=\"4.0\" language=\"jambi\">",
"Qt::NoFocus" => "Qt.FocusPolicy.NoFocus",
"Qt::ScrollBarAsNeeded" => "Qt.ScrollBarPolicy.ScrollBarAsNeeded",
#"\\.createQFlags\\(Qt.AlignmentFlag" => "Qt.AlignmentFlag.createQFlags(Qt.AlignmentFlag",
"Qt.AlignmentFlag.AlignLeading|" => "",
"|Qt.AlignmentFlag.AlignLeading" => "",
"Qt::LinksAccessibleByKeyboard" => "Qt.TextInteractionFlag.LinksAccessibleByKeyboard",
"Qt::LinksAccessibleByMouse" => "Qt.TextInteractionFlag.LinksAccessibleByMouse",
"Qt::NoTextInteraction" => "Qt.TextInteractionFlag.NoTextInteraction",
"Qt::TextBrowserInteraction" => "Qt.TextInteractionFlag.TextBrowserInteraction",
"Qt::TextEditable" => "Qt.TextInteractionFlag.TextEditable",
"Qt::TextEditorInteraction" => "Qt.TextInteractionFlag.TextEditorInteraction",
"Qt::TextSelectableByKeyboard" => "Qt.TextInteractionFlag.TextSelectableByKeyboard",
"Qt::TextSelectableByMouse" => "Qt.TextInteractionFlag.TextSelectableByMouse",
}
if ARGV.size < 1
	puts "U FAILED!"
else
	file_name = ARGV[0]
	if File.file? "ui/"+file_name+".ui"
		file = File.new("ui/"+file_name+".ui")
		lines = file.readlines
		file.close
		changes = false
		lines.each do |line|
			changes = true if line.gsub!(/Qt::Align([a-zA-Z]*)/){"Qt.AlignmentFlag.Align#{$1}"}
			swap.each do |a,b|
#				puts "#{a} -> #{b}"
				changes = true if line.gsub!(/#{a}/,"#{b}")
			end
		end
		if changes
			puts file_name+" changed !\n"
			file = File.new("jui/"+file_name+".jui",'w')
			lines.each do |line|
				file.write(line)
			end
			file.close
		end
	else
		puts "ui/"+file_name+".ui not exist !\n"
	end
end
