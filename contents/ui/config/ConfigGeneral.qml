import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.kquickcontrols as KQuick
import org.kde.kirigami as Kirigami

//TODO: Clean up this horrible mess
ColumnLayout {
    id: root

    property alias cfg_labelFontSize: labelFontSize.value
    property alias cfg_customLabel: customLabel.text
    property alias cfg_textColor: labelColor.color
    property alias cfg_customTextColorEnabled: customLabelColorEnabled.checked
    property alias cfg_progressColor: progressColor.color
    property alias cfg_customProgressColorEnabled: customProgressColorEnabled.checked
    property real centerFactor: 0.3
    property real minimumWidth: 100
    spacing: 5

    ColumnLayout {
        id:mainColumn
        spacing: Kirigami.Units.largeSpacing
        Layout.fillWidth: true

        Kirigami.InlineMessage {
            width: root.width
            height: 100
            text: "Put \'%y\' for year and \'%p\' for year progress."
            visible: customLabel.focus
        }
        RowLayout {
            Label{
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("Label:")
                horizontalAlignment: Label.AlignRight
            }
            TextField {
                id: customLabel
                placeholderText: i18n("Custom Label")
            }
        }
        GridLayout{
            columns: 2
            Label{Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)}
            SpinBox {
                id: labelFontSize
                textFromValue: value => {
                    return i18n("%1 pt", value)
                }
                x: label1.width
                stepSize: 1
                from: 8
                to: 48
            }
            Label{Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)}
            RowLayout{
                CheckBox {
                    x: label1.width
                    id: customLabelColorEnabled
                }
                Label{text: "Custom Colors Enabled"}
                KQuick.ColorButton {
                    id: labelColor
                    visible: customLabelColorEnabled.checked
                }
            }
        }
    }
    RowLayout {
        Label{
            text: "Progress Bar:"
            Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
            horizontalAlignment: Label.AlignRight
        }
        CheckBox {
            x: label1.width
            id: customProgressColorEnabled
        }
        Label{text: "Custom Colors Enabled"}
        KQuick.ColorButton {
            id: progressColor
            visible: customProgressColorEnabled.checked
        }
    }
}
