"use client";

import { useEffect, useEffectEvent, useRef } from "react";
import { BookIcon, CompassIcon, CrossIcon, FootprintsIcon } from "./icons";

export default function AboutModal({ onClose }: { onClose: () => void }) {
  const dialogRef = useRef<HTMLDivElement>(null);
  const closeModal = useEffectEvent(onClose);

  useEffect(() => {
    const previousActiveElement = document.activeElement as HTMLElement | null;
    const previousOverflow = document.body.style.overflow;

    document.body.style.overflow = "hidden";
    dialogRef.current?.focus();

    function handleKeyDown(event: KeyboardEvent) {
      if (event.key === "Escape") {
        closeModal();
        return;
      }

      if (event.key !== "Tab" || !dialogRef.current) return;

      const focusableElements = Array.from(
        dialogRef.current.querySelectorAll<HTMLElement>(
          'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])',
        ),
      ).filter((element) => !element.hasAttribute("disabled"));

      if (focusableElements.length === 0) {
        event.preventDefault();
        return;
      }

      const firstElement = focusableElements[0];
      const lastElement = focusableElements[focusableElements.length - 1];

      if (
        event.shiftKey &&
        (document.activeElement === firstElement ||
          document.activeElement === dialogRef.current)
      ) {
        event.preventDefault();
        lastElement.focus();
      } else if (!event.shiftKey && document.activeElement === lastElement) {
        event.preventDefault();
        firstElement.focus();
      }
    }

    document.addEventListener("keydown", handleKeyDown);
    return () => {
      document.removeEventListener("keydown", handleKeyDown);
      document.body.style.overflow = previousOverflow;
      previousActiveElement?.focus();
    };
  }, []);

  return (
    <div className="about-backdrop" onClick={onClose}>
      <article
        ref={dialogRef}
        className="about-dialog"
        role="dialog"
        aria-modal="true"
        aria-labelledby="about-title"
        aria-describedby="about-introduction"
        tabIndex={-1}
        onClick={(event) => event.stopPropagation()}
      >
        <button
          type="button"
          onClick={onClose}
          className="about-close"
          aria-label="Fechar apresentação do projeto"
          title="Fechar"
        >
          <span aria-hidden="true">×</span>
        </button>

        <div className="about-halo" aria-hidden="true">
          <CrossIcon className="about-halo-cross" />
        </div>

        <header className="about-hero">
          <span className="about-eyebrow">UM CONVITE À SANTIDADE</span>
          <h2 id="about-title">
            A santidade atravessa os séculos.
            <strong>E chama você hoje.</strong>
          </h2>
          <p id="about-introduction">
            A história da Igreja não é uma coleção de datas distantes. É a
            história da graça de Deus acolhida por homens e mulheres que, em
            cada tempo e lugar, entregaram a própria vida a Cristo.
          </p>
        </header>

        <blockquote className="about-scripture">
          <span aria-hidden="true">“</span>
          <p>Sede santos, porque Eu sou santo.</p>
          <cite>1 Pedro 1,16</cite>
        </blockquote>

        <div className="about-paths">
          <section className="about-path">
            <span className="about-path-icon" aria-hidden="true">
              <BookIcon className="h-5 w-5" />
            </span>
            <div>
              <h3>Conheça suas vidas</h3>
              <p>
                Descubra como pessoas reais responderam a Deus entre lutas,
                escolhas, quedas e uma fidelidade capaz de transformar o mundo.
              </p>
            </div>
          </section>

          <section className="about-path">
            <span className="about-path-icon" aria-hidden="true">
              <CompassIcon className="h-5 w-5" />
            </span>
            <div>
              <h3>Percorra a Igreja</h3>
              <p>
                Atravesse continentes e séculos, seguindo os caminhos dos
                santos, dos papas e das comunidades que guardaram a fé.
              </p>
            </div>
          </section>

          <section className="about-path">
            <span className="about-path-icon" aria-hidden="true">
              <FootprintsIcon className="h-5 w-5" />
            </span>
            <div>
              <h3>Encontre seus passos</h3>
              <p>
                Deixe que o testemunho dos santos ilumine o seu tempo e recorde
                a vocação que também foi confiada a você.
              </p>
            </div>
          </section>
        </div>

        <footer className="about-footer">
          <p>
            Sancta Historia nasce para tornar visível esta grande comunhão:
            uma Igreja viva, presente na história e conduzida por Deus.
          </p>
          <button type="button" onClick={onClose} className="about-cta">
            INICIAR ESTA JORNADA
            <span aria-hidden="true">→</span>
          </button>
        </footer>
      </article>
    </div>
  );
}
