# aliases only effective after v1.4.3
IRB.conf[:COMMAND_ALIASES] ||= {}
IRB.conf[:COMMAND_ALIASES][:ri] = :help

# Fix cursed white-on-cyan autocomplete
if defined?(Reline::Face) then
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define :default, foreground: :white, background: :blue
  end
else
  force_dialog_color = Module.new do
    def initialize(...)
      super
      self.bg_color = '36'
    end
  end
  Reline::DialogRenderInfo.prepend(force_dialog_color)
end
