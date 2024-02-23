import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami
PlasmoidItem {
    property real timeout: 3600 * 1000
    property string currentText: "%y% is %p%%complete"
    property real currentPercent: 0.0
    readonly property date currentDateTime: dataSource.data.Local ? dataSource.data.Local.DateTime : new Date()
    readonly property string currentYear: currentDateTime.getFullYear()
    property string customLabel: plasmoid.configuration.customLabel
    property date prevDateTime


    Layout.minimumWidth: (plasmoid.configuration.labelFontSize * customLabel.length)
    Layout.maximumHeight: Kirigami.Units.iconSizes.medium


    function calculatePercentage(first_date, second_date)
    {
        var days_in_year = 365 + ( currentYear % 4 || !(currentYear % 100) ? 1 : 0 );
        var ms = Math.abs(second_date.getTime() - first_date.getTime());
        var days_elapsed = Math.floor(ms/ (1000 * 3600 * 24));

        var result_percentage = 0.0;
        if(days_elapsed <= days_in_year) result_percentage = (days_elapsed/days_in_year)*100;
        return result_percentage.toFixed(1);
    }

    function checkDate() {
        var today = new Date();
        var first_day_of_year = new Date(currentYear, 0, 1);
        currentPercent = calculatePercentage(first_day_of_year, today);
        currentText = customLabel.replace(/%y/g, currentYear).replace(/%p/g, currentPercent+'%');
    }

    Plasma5Support.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: timeout
        intervalAlignment: Plasma5Support.Types.AlignToHour
    }

    onCurrentDateTimeChanged: {
        prevDateTime = currentDateTime;
        checkDate();
    }

    onCustomLabelChanged: checkDate();

    fullRepresentation: FullRepresentation {
        textInp: currentText
        progress: currentPercent
    }
    Component.onCompleted:
    {
        prevDateTime = currentDateTime
        checkDate();
    }
}
