class BaseGui {
    __New(options, title, eventObj) {
        this.GraphicInterface := Gui(options, title, eventObj)
    }

    AddNewEventHandler(control, event, function) {
        this.GraphicInterface[control].OnEvent(event, function)
        return
    }

    AddOptionsToControl(control, options) {
        this.GraphicInterface[control].Opt(options)
        return
    }

    AddOptionsToBase(options) {
        this.GraphicInterface.Opt(options)
        return
    }

    AddTextControl(options, content) {
        this.GraphicInterface.Add("Text", options, content)
        return
    }

    AddTextControls(ids) {
        for item in ids {
            this.AddTextControl("v" item.Id " " item.Options, item.Content)
            if StrLen(item.Font) > 0
                this.UpdateTextFont(item.Id, item.Font)
        }
        return
    }

    UpdateTextFont(name, options) {
        this.GraphicInterface[name].SetFont(options)
        return
    }

    AddTabControl(options, tabs) {
        this.GraphicInterface.Add("Tab3", options, tabs)
        return
    }

    UseTabControl(tabs, name, caseSensitive := true) {
        this.GraphicInterface[tabs].UseTab(name, caseSensitive)
        return
    }

    AddGroupControl(groupOptions, grouptext) {
        this.GraphicInterface.Add("GroupBox", groupOptions, groupText)
        return
    }

    AddDropdownControl(options, items) {
        this.GraphicInterface.Add("DropDownList", options, items)
        return
    }

    AddDropdownComponents(ids) {
        for item in ids {
            this.AddTextControl(item.Header.Options, item.Header.Content)
            if StrLen(item.Header.Font) > 0
                this.UpdateTextFont(item.Id, item.Header.Font)
            this.AddDropdownControl("v" item.Id " " item.Options, item.Items)
        }
    }

    AddButtonControl(options, content) {
        this.GraphicInterface.Add("Button", options, content)
    }

    AddEditControl(options, content := unset) {
        this.GraphicInterface.Add("Edit", options, IsSet(content) ? content : unset)
    }

    AddUpDownControl(options, content := unset) {
        this.GraphicInterface.Add("UpDown", options, IsSet(content) ? content : unset)
    }

    AddEventHandler(event, function, control := unset) {
        if !IsSet(control)
            this.GraphicInterface.OnEvent(event, function)
        else
            this.GraphicInterface[control].OnEvent(event, function)
    }

    GetControl(name := unset) {
        if !IsSet(name) {
            return this.GraphicInterface
        } else {
            return this.GraphicInterface[name]
        }
    }
}