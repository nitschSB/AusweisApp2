function escapeHtml(str)
{
	return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

function isToday(date)
{
	var today = new Date;
	return isSameDate(today, date);
}

function isYesterday(date)
{
	var yesterday = new Date;
	yesterday.setDate(yesterday.getDate() - 1);
	return isSameDate(yesterday, date);
}

function isThisWeek(date)
{
	var monday = new Date;
	monday.setDate(monday.getDate()-monday.getDay());

	date.setDate(date.getDate()-date.getDay());

	return isSameDate(monday, date);
}

function isSameDate(one, another)
{
	return one.getFullYear() === another.getFullYear() && one.getMonth() === another.getMonth() && one.getDate() === another.getDate();
}

function getRandomInt(min, max)
{
	return Math.floor(Math.random() * (max - min)) + min;
}

function providerIconSource(baseName) {
	var platform = plugin.platformStyle.indexOf("tablet") !== -1 ? "+tablet/" : ""

	return "qrc:///images/provider/" + platform + baseName + ".png"
}

function scrollPageDown(pFlickable) {
	if (pFlickable.height >= pFlickable.contentHeight) {
		return
	}

	pFlickable.contentY += pFlickable.height
	if (pFlickable.contentY + pFlickable.height > pFlickable.contentHeight) {
		pFlickable.contentY = pFlickable.contentHeight - pFlickable.height
	}
}

function scrollPageUp(pFlickable) {
	if (pFlickable.height >= pFlickable.contentHeight) {
		return
	}

	pFlickable.contentY -= pFlickable.height
	if (pFlickable.contentY < 0) {
		pFlickable.contentY =  0
	}
}
