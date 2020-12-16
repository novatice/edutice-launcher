import QtQuick 2.0
import QtQml.Models 2.3

DelegateModel{
    function update() {
        console.log("de");
        for (var i = 0; i < items.count && i < 6; i++) {
            items.setGroups(i, 1, ['items', 'filter'])
        }
    }

    items.onChanged: update()
    groups: DelegateModelGroup { name: 'filter' }

    filterOnGroup: 'filter'
}
