#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QIcon>

#include "Driver.h"
#include "ImageProvider.h"

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	app.setWindowIcon(QIcon(u":/PixelPeek/icons8-picture-94.png"_qs));

	QQuickStyle::setStyle("Windows");
	app.setOrganizationName("MoustaphaSaad");
	app.setOrganizationDomain("moustapha.xyz");
	app.setApplicationName("PixelPeek");

	QQmlApplicationEngine engine;
	engine.addImageProvider("history", new ImageProvider{Driver::singleton()});
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
					 &app, []() { QCoreApplication::exit(-1); },
	Qt::QueuedConnection);
	engine.loadFromModule("PixelPeek", "Main");

	return app.exec();
}
