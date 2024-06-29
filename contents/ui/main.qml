import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plaimport QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    property int timeout: plasmoid.configuration.updateFrequency * 1000 // Update interval in milliseconds
    property int precision: plasmoid.configuration.precision // Precision for the percentage
    property string currentText: "%y% is %p%% complete"
    property real currentPercent: 0.0
    readonly property date currentDateTime: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()
    readonly property string currentYear: currentDateTime.getFullYear()
    property string customLabel: plasmoid.configuration.customLabel
    property date prevDateTime

    Layout.minimumWidth: (plasmoid.configuration.labelFontSize * customLabel.length)
    Layout.maximumHeight: Kirigami.Units.iconSizes.medium

    function calculatePercentage(first_date, second_date) {
        var days_in_year = 365 + ((currentYear % 4 === 0 && currentYear % 100 !== 0) || (currentYear % 400 === 0) ? 1 : 0);
        var ms = second_date.getTime() - first_date.getTime();
        var year_ms = days_in_year * 24 * 60 * 60 * 1000;

        var result_percentage = (ms / year_ms) * 100;
        return result_percentage.toFixed(precision); // Adjusted to configurable precision
    }

    function updateValues() {
        var today = new Date();
        var first_day_of_year = new Date(currentYear, 0, 1);
        currentPercent = calculatePercentage(first_day_of_year, today);
        currentText = customLabel.replace(/%y/g, currentYear).replace(/%p/g, currentPercent + '%');
    }

    Plasma5Support.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: timeout
        intervalAlignment: Plasma5Support.Types.AlignToHour
    }

    Timer {
        interval: timeout
        running: true
        repeat: true
        onTriggered: updateValues()
    }

    onCurrentDateTimeChanged: {
        prevDateTime = currentDateTime;
        updateValues();
    }

    onCustomLabelChanged: updateValues();

    fullRepresentation: FullRepresentation {
        textInp: currentText
        progress: currentPercent
    }

    Component.onCompleted: {
        prevDateTime = currentDateTime;
        updateValues();
    }
}
sma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    property int timeout: plasmoid.configuration.updateFrequency * 1000 // Update interval in milliseconds
    property int precision: plasmoid.configuration.precision // Precision for the percentage
    property string currentText: "%y% is %p%% complete"
    property real currentPercent: 0.0
    readonly property date currentDateTime: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()
    readonly property string currentYear: currentDateTime.getFullYear()
    property string customLabel: plasmoid.configuration.customLabel
    property date prevDateTime

    Layout.minimumWidth: (plasmoid.configuration.labelFontSize * customLabel.length)
    Layout.maximumHeight: Kirigami.Units.iconSizes.medium

    function calculatePercentage(first_date, second_date) {
        var days_in_year = 365 + ((currentYear % 4 === 0 && currentYear % 100 !== 0) || (currentYear % 400 === 0) ? 1 : 0);
        var ms = second_date.getTime() - first_date.getTime();
        var year_ms = days_in_year * 24 * 60 * 60 * 1000;

        var result_percentage = (ms / year_ms) * 100;
        return result_percentage.toFixed(precision); // Adjusted to configurable precision
    }

    function updateValues() {
        var today = new Date();
        var first_day_of_year = new Date(currentYear, 0, 1);
        currentPercent = calculatePercentage(first_day_of_year, today);
        currentText = customLabel.replace(/%y/g, currentYear).replace(/%p/g, currentPercent + '%');
    }

    Plasma5Support.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: timeout
        intervalAlignment: Plasma5Support.Types.AlignToHour
    }

    Timer {
        interval: timeout
        running: true
        repeat: true
        onTriggered: updateValues()
    }

    onCurrentDateTimeChanged: {
        prevDateTime = currentDateTime;
        updateValues();
    }

    onCustomLabelChanged: updateValues();

    fullRepresentation: FullRepresentation {
        textInp: currentText
        progress: currentPercent
    }

    Component.onCompleted: {
        prevDateTime = currentDateTime;
        updateValues();
    }
}

