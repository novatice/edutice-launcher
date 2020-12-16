import QtQuick 2.9
import QtQml.Models 2.3

DelegateModel {
    id: delegateModel

    property var viewIndex : 0
    property var lessThan: function(left, right) { return true; }
    property var filterAcceptsItem: function(item) { return true; }
    property var updateCategorie: function() { return true; }
    property var modelCategories;

    function update() {
        if (items.count > 0) {
            items.setGroups(0, items.count, "items");
        }

        // Step 1: Filter items
        var visible = [];
        for (var i = 0; i < items.count; ++i) {
            var item = items.get(i);
            if (filterAcceptsItem(item.model))
            {
                visible.push(item);
            }
        }

        // Step 2: Sort the list of visible items
        visible.sort(function(a, b) {
            return lessThan(a.model, b.model);
        });

        // Step 3: Add all items to the visible group:
        for (i = 0; i < visible.length; ++i) {
            item = visible[i];
            item.inVisible = true;
            if (item.visibleIndex !== i) {
                visibleItems.move(item.visibleIndex, i, 1);
            }
        }
        /**/
    }

    items.onChanged: {
        update();
        updateCategorie();
    }

    onLessThanChanged: update()

    onFilterAcceptsItemChanged: update()

    groups: DelegateModelGroup {
        id: visibleItems
        name: "visible"
        includeByDefault: false
    }

    filterOnGroup: "visible"
}
