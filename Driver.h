#pragma once

#include <QObject>
#include <QString>
#include <qqml.h>

#include "BuildInfo.h"

class Driver: public QObject
{
	Q_OBJECT
	Q_PROPERTY(QString version READ version CONSTANT)
	QML_ELEMENT
	QML_SINGLETON
public:
	Driver(QObject* parent = nullptr)
		: QObject(parent)
	{}

	QString version() const { return VERSION; }
};
