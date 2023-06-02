class EventComponent {
    __New(event, function, control := unset) {
        this.Event := event
        this.Function := function
        this.Control := !IsSet(control) ? unset : control
        this.HasControl := IsSet(control)
    }
}