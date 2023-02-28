#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QIcon>


int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	app.setWindowIcon(QIcon(u":/PixelPeek/icons8-picture-94.png"_qs));

	QQuickStyle::setStyle("Windows");
	app.setOrganizationName("MoustaphaSaad");
	app.setOrganizationDomain("moustapha.xyz");
	app.setApplicationName("PixelPeek");

	QQmlApplicationEngine engine;
	const QUrl url(u"qrc:/PixelPeek/main.qml"_qs);
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

	return app.exec();
}
