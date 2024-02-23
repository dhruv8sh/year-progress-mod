import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.kquickcontrols as KQuick
import org.kde.kirigami as Kirigami


Item {
    id: root

    property alias cfg_labelFontSize: labelFontSize.value
    property alias cfg_labelColor: labelColor.color
    property alias cfg_customLabel: customLabel.text

    Kirigami.FormLayout {
        SpinBox {
            id: labelFontSize
            Kirigami.FormData.label: i18n("Label font size:")
            textFromValue: function (value) {
                return i18nc("%1 is font size in points (pt)", "%1 pt", value)
            }
            stepSize: 1
            from: 10
            to: 48
        }

        KQuick.ColorButton {
            id: labelColor
            Kirigami.FormData.label: i18n("Label color:")
        }

        TextField {
            id: customLabel
            placeholderText: "Message"
            Kirigami.FormData.label: i18n("Message:")
        }
        Label{
            text: "Put \'%y%\' for year \nand \'%p%\' for the progress"
        }

    }
}
