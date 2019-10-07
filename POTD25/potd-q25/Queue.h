#pragma once

#include <cstddef>

class Queue {
    public:
        Queue();
        ~Queue();
        Queue(const Queue& other);
        Queue& operator=(const Queue& other);
        int size() const;
        bool isEmpty() const;
        void enqueue(int value);
        int dequeue();
    private:
        int* data;
        unsigned length;
        unsigned capacity;
        int front;
        void _copy(const Queue& other);
        void _clean();
};