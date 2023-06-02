from pandemonium import exposed, ResourceLoader


GDNode = ResourceLoader.load("res://gdnode.gd", "", False)


@exposed
class PyNodeWithGDParent(GDNode):
    pass
