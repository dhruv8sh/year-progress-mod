import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.kquickcontrols as KQuick
import org.kde.kirigami as Kirigami

//TODO: Clean up this horrible mess
Item {
    id: root

    property alias cfg_labelFontSize: labelFontSize.value
    property alias cfg_customLabel: customLabel.text
    property alias cfg_textColor: labelColor.color
    property alias cfg_customTextColorEnabled: customLabelColorEnabled.checked
    property alias cfg_progressColor: progressColor.color
    property alias cfg_customProgressColorEnabled: customProgressColorEnabled.checked
    property int confWidth: 300
    ColumnLayout {
        Kirigami.InlineMessage {
            width: 350
            //customLabel.width
            height: 100
            text: "Put \'%y\' for year and \'%p\' for year progress."
            visible: true
        }
        RowLayout {
            Label {
                text: i18n("Label:")
                width: label.width
                horizontalAlignment: Label.AlignRight
            }
            TextField {
                id: customLabel
                placeholderText: i18n("Custom Label")
            }
        }
        RowLayout {
            SpinBox {
                id: labelFontSize
                textFromValue: function (value) {
                    return i18nc("%1 is font size in points (pt)", "%1 pt", value)
                }
                x: label1.width
                stepSize: 1
                from: 8
                to: 48
            }
            Label {
                text: i18n("Font Size")
            }
        }
        RowLayout {
            CheckBox {
                x: label1.width
                id: customLabelColorEnabled
            }
            Label {
                text: i18n("Enable Custom Color")
            }
        }
        RowLayout {
            Label {
                width: label.width
                horizontalAlignment: Label.AlignRight
            }
            KQuick.ColorButton {
                id: labelColor
                text: i18n("Color")
                visible: customLabelColorEnabled.checked
            }
        }
        RowLayout {
            Label {
                id: label1
                width: label.width
                horizontalAlignment: Label.AlignRight
                text: i18n("Progress Bar:")
            }
            CheckBox {
                id: customProgressColorEnabled
            }
        }
        RowLayout {
            Label {
                width: label.width
                horizontalAlignment: Label.AlignRight
            }
            KQuick.ColorButton {
                id: progressColor
                visible: customProgressColorEnabled.checked
            }
        }
    }
}
