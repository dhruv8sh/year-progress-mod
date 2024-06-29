import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.kquickcontrols as KQuick
import org.kde.kirigami as Kirigami

Item {
    width: 400
    height: 400
    ColumnLayout {
        id: root
        anchors.centerIn: parent
        spacing: Kirigami.Units.largeSpacing

        Kirigami.InlineMessage {
            width: parent.width
            height: 100
            text: "Put '%y' for year and '%p' for year progress."
            visible: customLabel.focus
        }

        GridLayout {
            id: mainGrid
            columns: 3
            columnSpacing: Kirigami.Units.largeSpacing
            rowSpacing: Kirigami.Units.smallSpacing
            Layout.fillWidth: true

            Label {
                text: i18n("Label:")
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: customLabel
                placeholderText: i18n("Custom Label")
                text: root.cfg_customLabel
                onTextChanged: root.cfg_customLabel = text
                Layout.columnSpan: 2
                Layout.fillWidth: true
            }

            Label {
                text: i18n("Font Size:")
                Layout.alignment: Qt.AlignRight
            }
            SpinBox {
                id: labelFontSize
                textFromValue: value => {
                    return i18n("%1 pt", value)
                }
                value: root.cfg_labelFontSize
                stepSize: 1
                from: 8
                to: 48
                onValueChanged: root.cfg_labelFontSize = value
                Layout.minimumWidth: 70
                Layout.preferredWidth: 70
                Layout.fillWidth: false
            }
            Item { Layout.fillWidth: true } // Spacer

            Label {
                text: i18n("Update Frequency (seconds):")
                Layout.alignment: Qt.AlignRight
            }
            SpinBox {
                id: updateFrequency
                value: root.cfg_updateFrequency
                stepSize: 1
                from: 1
                to: 60
                onValueChanged: root.cfg_updateFrequency = value
                Layout.minimumWidth: 50
                Layout.preferredWidth: 50
                Layout.fillWidth: false
            }
            Item { Layout.fillWidth: true } // Spacer

            Label {
                text: i18n("Precision (decimal places):")
                Layout.alignment: Qt.AlignRight
            }
            SpinBox {
                id: precision
                value: root.cfg_precision
                stepSize: 1
                from: 0
                to: 10
                onValueChanged: root.cfg_precision = value
                Layout.minimumWidth: 50
                Layout.preferredWidth: 50
                Layout.fillWidth: false
            }
            Item { Layout.fillWidth: true } // Spacer

            Label {
                text: i18n("Text Color:")
                Layout.alignment: Qt.AlignRight
            }
            KQuick.ColorButton {
                id: labelColor
                color: root.cfg_textColor
                enabled: customLabelColorEnabled.checked
                onColorChanged: root.cfg_textColor = color
                Layout.minimumWidth: 70
                Layout.preferredWidth: 70
                Layout.fillWidth: false
            }
            CheckBox {
                id: customLabelColorEnabled
                checked: root.cfg_customTextColorEnabled
                onCheckedChanged: root.cfg_customTextColorEnabled = checked
                Layout.alignment: Qt.AlignLeft
            }

            Label {
                text: i18n("Progress Bar Color:")
                Layout.alignment: Qt.AlignRight
            }
            KQuick.ColorButton {
                id: progressColor
                color: root.cfg_progressColor
                enabled: customProgressColorEnabled.checked
                onColorChanged: root.cfg_progressColor = color
                Layout.minimumWidth: 70
                Layout.preferredWidth: 70
                Layout.fillWidth: false
            }
            CheckBox {
                id: customProgressColorEnabled
                checked: root.cfg_customProgressColorEnabled
                onCheckedChanged: root.cfg_customProgressColorEnabled = checked
                Layout.alignment: Qt.AlignLeft
            }
        }
    }

    // Configuration property aliases
    property alias cfg_labelFontSize: labelFontSize.value
    property alias cfg_customLabel: customLabel.text
    property alias cfg_textColor: labelColor.color
    property alias cfg_customTextColorEnabled: customLabelColorEnabled.checked
    property alias cfg_progressColor: progressColor.color
    property alias cfg_customProgressColorEnabled: customProgressColorEnabled.checked
    property alias cfg_updateFrequency: updateFrequency.value
    property alias cfg_precision: precision.value
}

