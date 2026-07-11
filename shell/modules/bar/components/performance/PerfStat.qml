import QtQuick
import QtQuick.Layouts
import Caelestia.Config
import qs.components
import qs.services

StyledRect {
    id: root

    required property string icon
    required property string valueText
    property color accent: Colours.palette.m3primary
    property real value: NaN

    readonly property bool isHorizontal: Config.bar.position === "top" || Config.bar.position === "bottom"
    readonly property int barThickness: Math.round(Tokens.sizes.bar.innerWidth * Math.max(0.6, !isNaN(Config.bar.scale) ? Config.bar.scale : 1.0))
    readonly property real progress: isNaN(value) ? 0 : Math.max(0, Math.min(1, value))

    color: Colours.tPalette.m3surfaceContainer
    radius: Tokens.rounding.full

    implicitWidth: isHorizontal ? (contentRow.implicitWidth + Tokens.padding.medium * 2) : barThickness
    implicitHeight: isHorizontal ? barThickness : (contentCol.implicitHeight + Tokens.padding.medium * 2)

    StyledRect {
        id: progressLayer

        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: isHorizontal ? undefined : parent.right
        anchors.top: isHorizontal ? undefined : parent.top

        width: isHorizontal ? parent.width * root.progress : parent.width
        height: isHorizontal ? Math.max(2, Tokens.padding.extraSmall) : parent.height * root.progress

        color: Qt.alpha(root.accent, 0.2)
        radius: parent.radius

        Behavior on width {
            enabled: root.isHorizontal
            Anim {
                type: Anim.FastSpatial
            }
        }

        Behavior on height {
            enabled: !root.isHorizontal
            Anim {
                type: Anim.FastSpatial
            }
        }
    }

    RowLayout {
        id: contentRow

        anchors.centerIn: parent
        visible: root.isHorizontal
        spacing: Tokens.spacing.small

        MaterialIcon {
            text: root.icon
            color: root.accent
            fill: 1
        }

        StyledText {
            text: root.valueText
            color: root.accent
            font: Tokens.font.body.builders.small.weight(Font.DemiBold).build()
            animate: true
        }
    }

    ColumnLayout {
        id: contentCol

        anchors.centerIn: parent
        visible: !root.isHorizontal
        spacing: Tokens.spacing.extraSmall

        MaterialIcon {
            Layout.alignment: Qt.AlignHCenter
            text: root.icon
            color: root.accent
            fill: 1
        }

        StyledText {
            Layout.alignment: Qt.AlignHCenter
            text: root.valueText
            color: root.accent
            font: Tokens.font.body.builders.small.weight(Font.DemiBold).build()
            animate: true
        }
    }
}
