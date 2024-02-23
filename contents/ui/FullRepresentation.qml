import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.kirigami as Kirigami

Item {
    property string textInp
    property real progress
    property color progressColor: plasmoid.configuration.progressColor
    property color customTextColor: plasmoid.configuration.textColor
    Layout.minimumWidth: (plasmoid.configuration.labelFontSize * customLabel.length)
    Layout.maximumHeight: plasmoid.configuration.labelFontSize * 10
    Label{
        id: percentageLabel
        z: 1
        anchors.centerIn: parent
        text: textInp
        font.pointSize: plasmoid.configuration.labelFontSize
        color: plasmoid.configuration.customTextColorEnabled ? customTextColor : Kirigami.Theme.textColor
    }
    Rectangle {
        z: 0
        x: -Kirigami.Units.smallSpacing
        y: -Kirigami.Units.smallSpacing
        id: progressBar
        height: parent.height + ( 2 * Kirigami.Units.smallSpacing)
        width: (progress * parent.width / 100) + (2*Kirigami.Units.smallSpacing)
        anchors.left: plasmoid.left
        color: plasmoid.configuration.customProgressColorEnabled ? progressColor : Kirigami.Theme.highlightColor
    }
}
