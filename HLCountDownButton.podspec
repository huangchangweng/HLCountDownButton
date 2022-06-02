Pod::Spec.new do |spec|

  spec.name         = "HLCountDownButton"
  spec.version      = "1.0.1"
  spec.summary      = "倒计时按钮，可通过xib、storyboard自定义样式"

  # 描述
  spec.description  = <<-DESC
      倒计时按钮，可通过xib、storyboard自定义样式
      支持丰富的样式定义
  DESC

  # 项目主页
  spec.homepage     = "https://github.com/huangchangweng/HLCountDownButton"
 
  # 开源协议
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  # 作者
  spec.author             = { "黄常翁" => "599139419@qq.com" }
  
  # 支持平台
  spec.platform     = :ios, "9.0"

  # git仓库，tag
  spec.source       = { :git => "https://github.com/huangchangweng/HLCountDownButton.git", :tag => "1.0.0" }

  # 资源路径
  spec.source_files  = "HLCountDownButton/HLCountDownButton/*.{h,m}"

  # 依赖系统库
  spec.frameworks = "UIKit"

end
