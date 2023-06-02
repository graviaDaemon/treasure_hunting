#Include <GraphicUserInterface\BaseComponent>

class DropdownComponent extends BaseComponent {
    __New(id, options, txtComp, items) {
        super.Id := id
        super.options := options

        this.Header := txtComp
        this.Items := items
    }
}