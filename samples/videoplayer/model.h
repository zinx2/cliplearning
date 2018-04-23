#pragma once
#include <QObject>
class Model : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool full READ full WRITE extend NOTIFY fullChanged)

private:
    Model() { };
    static Model* m_instance;
public:
    static Model* instance() {
        if (m_instance == nullptr) m_instance = new Model();
        return m_instance;
    }
    bool full() const { return m_full; }

    public slots:
    void extend(bool m) { m_full = m; emit fullChanged(); }

signals:
    void fullChanged();

private:
    bool m_full = false;

};
