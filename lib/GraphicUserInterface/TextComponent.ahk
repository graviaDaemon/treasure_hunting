#Include <GraphicUserInterface\BaseComponent>

class TextComponent extends BaseComponent {
    __New(id, options, content, font := "") {
        super.Id := id
        super.options := options

        this.Content := content
        this.Font := font
    }
}