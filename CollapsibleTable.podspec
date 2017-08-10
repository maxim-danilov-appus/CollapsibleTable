Pod::Spec.new do |s|
  s.name               = "CollapsibleTable"
  s.version            = "1.1.0"
  s.summary            = "A collapsible table view mechanism."
  s.description        = "A table view of collapsing table view sections"
  s.homepage           = "https://github.com/rob-nash/CollapsibleTable"
  s.screenshots        = "https://i.imgur.com/HjznyIf.gif"
  s.license            = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Robert Nash" => "robscode@icloud.com" }
  s.social_media_url   = "http://twitter.com/rob__nash"
  s.platform           = :ios, "8.0"
  s.source             = { :git => "https://github.com/rob-nash/CollapsibleTable.git", :tag => "#{s.version}" }
  s.source_files       = "CollapsibleTable/*.{swift}"
  s.requires_arc       = true
end
