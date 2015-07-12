package link_sharing

public enum Seriousness {
CASUAL("Casual"),
SERIOUS("Serious"),
VERY_SERIOUS("Very Serious")
private final String name;

    Seriousness(String name) {
this.name = name

}

public String getValue() { return this.name }
public String toString() {
return this.name;
}
}
