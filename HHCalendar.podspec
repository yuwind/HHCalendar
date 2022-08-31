
Pod::Spec.new do |s|
  s.name         = 'HHCalendar' 
  s.version      = '1.0.1'
  s.summary      = 'HHCalendar'
  s.description  = 'ui common method'
  s.homepage     = 'https://github.com/yuwind/HHCalendar/wiki'
  s.license      = 'MIT'
  s.author       = { 'yufeng' => '991810133@qq.com' }
  s.platform     = :ios, '10.0'
  s.source       = { :git => "https://github.com/yuwind/HHCalendar.git", :tag => s.version}
  s.source_files = 'HHCalendar/*.{h,m}'
  s.resource     = 'HHCalendar/HHCalendarBundle.bundle'
  s.requires_arc = true
  s.dependency 'HHCommon'

end
